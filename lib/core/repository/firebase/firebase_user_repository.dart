import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseUserRepository extends Repository<User> {
  @override
  Future<User> add(User data) async {
    DocumentSnapshot userSnapshot = await dbAPI.addDocument(
        FirestoreAPI.usersCollection, data.toJson(),
        docID: data.id);
    return User().fromSnapshot(userSnapshot);
  }

  @override
  Future<bool> delete(User data) {
    return dbAPI.removeDocument(FirestoreAPI.usersCollection, data.id);
  }

  @override
  Future<User> get(String id) async {
    DocumentSnapshot userSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.usersCollection, id);
    return User().fromSnapshot(userSnapshot);
  }

  @override
  Future<List<User>> getList(
      {SearchItem searchItem = const SearchItem(
          collectionName: FirestoreAPI.usersCollection)}) async {
    QuerySnapshot querySnapshot = await dbAPI.getDataCollection(searchItem);

    if(querySnapshot != null){
      return querySnapshot.documents
        .map((documentSnapshot) => User().fromSnapshot(documentSnapshot))
        .toList();
    }
    else{
      return List.empty();
    }
  }

  @override
  Stream<List<User>> getStreamList(
      {SearchItem searchItem =
          const SearchItem(collectionName: FirestoreAPI.usersCollection)}) {
    Stream<QuerySnapshot> querySnapshots =
        dbAPI.getStreamDataCollection(searchItem);

    if(querySnapshots != null){
      return querySnapshots.map((querySnapshot) => querySnapshot.documents
        .map((documentSnapshot) => User().fromSnapshot(documentSnapshot))
        .toList());
    }
    else{
      return Stream.empty();
    }
  }

  @override
  Future<bool> update(User data) {
    return dbAPI.updateDocument(data.toJson(),
        path: null, id: null, isIDUpdatable: false, reference: data.reference);
  }

  Future<FirebaseUser> getAuthUser() async {
    return authAPI.currentUser();
  }

  Future<User> getUserByUID({@required String uid}) async {
    QuerySnapshot querySnapshot = await dbAPI.getDocumentByField(
      searchItem: SearchItem(
        collectionName: FirestoreAPI.usersCollection,
        fieldName: FirebaseUserRepository.dbFieldNames[UserFields.userUID],
        value: uid,
      ),
    );

    if (querySnapshot != null) {
      DocumentSnapshot userSnapshot = querySnapshot.documents.first;
      return User().fromSnapshot(userSnapshot);
    }

    return null;
  }

  Future<User> getCurrentUser() async {
    try {
      String currentUserUid = await authAPI.currentUserUid();
      return await getUserByUID(uid: currentUserUid);
    } catch (e) {
      bool isAnonymous = await authAPI.isAnonymous();
      if (!isAnonymous) {
        FirestoreExceptionHandler.tryGetMessage(e);
      }

      return null;
    }
  }

  Future<void> resetPassword({@required String email}) async {
    await authAPI.resetPassword(email: email);
  }

  Future<void> signInAnonymously() async {
    return authAPI.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await authAPI.googleSignIn();
    if (googleAccount != null) {
      final AuthCredential credential = authAPI.getCredentialFromGoogleAuth(
          googleSignInAuthentication: await googleAccount.authentication);
      return authAPI.signInWithCredentials(credential);
    }

    return Future.error('Google sign in cancelled');
  }

  Future<void> signInWithCredentials(
      {@required String email, @required String password}) async {
    return authAPI.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> get isEmailVerified => authAPI.isEmailVerified();

  Future<String> get nickname async {
    final user = await getCurrentUser();
    if (user == null) {
      bool isAnonymous = await authAPI.isAnonymous();
      if (isAnonymous) {
        return 'Anonymous';
      } else {
        print(
            "Error getting nickname: no current user and account isn't anonymous");
        return '';
      }
    } else {
      return user.nickname;
    }
  }

  Future<bool> signUp(
      {@required String nickname,
      @required String email,
      @required String password}) async {
    //use firebase auth user.displayname to set nickname?
    AuthResult authResult = await authAPI.createUserWithEmailAndPassword(
        email: email, password: password);
    if (authResult != null) {
      await _createUser(authResult, nickname);
      await locator<FirebaseSettingsRepository>().addNewUserSettings();
      return true;
    }

    return false;
  }

  Future<bool> isSignedIn() async {
    final FirebaseUser currentUser = await authAPI.currentUser();

    return currentUser != null;
  }

  Future<void> signIn(
      {@required String email, @required String password}) async {
    return authAPI.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait([
      authAPI.signOut(),
      authAPI.googleSignOut(),
    ]);
  }

  _createUser(AuthResult authResult, String nickname) async {
    User user = User.newUser()
      ..userUID = authResult.user.uid
      ..nickname = nickname;
    await add(user);
  }

  static Map<UserFields, String> dbFieldNames = <UserFields, String>{
    UserFields.createdTime: 'ct',
    UserFields.userUID: 'uid',
    UserFields.nickname: 'n',
    UserFields.firstName: 'fn',
    UserFields.lastName: 'ln',
    UserFields.friendIDs: 'fs',
    UserFields.careerID: 'c',
    UserFields.isAdmin: 'ad',
  };
}
