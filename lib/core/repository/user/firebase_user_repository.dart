import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maverick_trials/core/models/search_item.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/repository/settings/firebase_settings_repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseUserRepository extends Repository {
  User _currentUser;

  Future<void> addUser(User user) async {
    await dbAPI.addDocument(FirestoreAPI.usersCollection, user.toJson(), docID: user.nickname);
  }

  Future<void> removeUser(User user) async {
    return await dbAPI.removeDocument(
        FirestoreAPI.usersCollection, user.nickname);
  }

  Future<void> updateUser(User user) async {
    return await dbAPI.updateDocument(
        FirestoreAPI.usersCollection, user.toJson(), user.nickname);
  }

  Future<User> getUser({@required String id}) async {
    DocumentSnapshot userSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.usersCollection, id);
    return User.fromJson(userSnapshot.data);
  }

  Future<User> getUserByUID({@required String uid}) async {
      QuerySnapshot snapshot = await dbAPI.getDocumentByField(
        searchItem: SearchItem(
          collectionName: FirestoreAPI.usersCollection,
          fieldName: FirebaseUserRepository.dbFieldNames[UserFields.userUID],
          value: uid,
        ),
      );
      DocumentSnapshot userSnapshot = snapshot.documents.first;
      return User.fromJson(userSnapshot.data);
  }

  Future<User> getCurrentUser() async {
    print('_current user: ${_currentUser?.nickname}');
    if (_currentUser != null) {
      return _currentUser;
    }

    try{
      String currentUserUid = await authAPI.currentUserUid();
      print('current user uid: $currentUserUid');
      _currentUser = await getUserByUID(uid: currentUserUid);
    }
    catch(e, st){
      if(e is PlatformException){
        print('Exception in getCurrentUser(): ${e.toString()} - $st');
      }
      else{
        print('Exception in getCurrentUser(): An Unknown Error Occurred - $st');
      }
    }

    return _currentUser;
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
    print('nickname of user: ${user.nickname}');
    return user.nickname;
  }

  Future<bool> signUp(
      {@required String nickname,
      @required String email,
      @required String password}) async {
    /*return authAPI.createUserWithEmailAndPassword(email: email, password: password)
      .then((authResult){
        _createUser(authResult, nickname);
        signOut();
        return true;
    }).catchError((error){
      return false;
    });

     */

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

  Future<FirebaseUser> getAuthUser() async {
    return authAPI.currentUser();
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
    User user = User(DateTime.now(), authResult.user.uid, nickname);
    await addUser(user);
  }

  static Map<UserFields, String> dbFieldNames = <UserFields, String>{
    UserFields.createdTime: 'ct',
    UserFields.userUID: 'uid',
    UserFields.nickname: 'n',
    UserFields.firstName: 'fn',
    UserFields.lastName: 'ln',
    UserFields.friendIDs: 'fs',
    UserFields.careerID: 'c',
    UserFields.settingsID: 's',
    UserFields.isAdmin: 'ad',
  };
}
