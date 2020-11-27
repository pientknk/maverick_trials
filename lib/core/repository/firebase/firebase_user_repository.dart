import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maverick_trials/core/caches/cache_manager.dart';
import 'package:maverick_trials/core/caches/user_cache.dart';
import 'package:maverick_trials/core/exceptions/firestore_exception_handler.dart';
import 'package:maverick_trials/core/logging/logging.dart';
import 'package:maverick_trials/core/models/base/search_item.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/repository/firebase/firebase_settings_repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';
import 'package:maverick_trials/locator.dart';

class FirebaseUserRepository extends Repository<User> {
  UserCache _userCache;

  FirebaseUserRepository(){
    _userCache = dbAPI.cacheManager.cacheMap[CacheType.user];
  }

  @override
  Future<User> add(User data) async {
    DocumentSnapshot userSnapshot = await dbAPI.addDocument(
        FirestoreAPI.usersCollection, data.toJson(),
        docID: data.id);
    User user = User().fromSnapshot(userSnapshot);
    user.firebaseUser = data.firebaseUser;

    return user;
  }

  @override
  Future<bool> delete(User data) {
    return dbAPI.removeDocument(FirestoreAPI.usersCollection, data.id);
  }

  @override
  Future<User> get(String id) async {
    DocumentSnapshot userSnapshot =
        await dbAPI.getDocumentById(FirestoreAPI.usersCollection, id);
    User user = User().fromSnapshot(userSnapshot);
    _userCache.addData(user);

    return user;
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
      path: FirestoreAPI.usersCollection,
      id: null,
      isIDUpdatable: false,
      reference: data.reference);
  }

  Future<FirebaseUser> getAuthUser() async {
    return authAPI.currentUser();
  }

  Future<User> _getUser({
    @required FirebaseUser firebaseUser,
  }) async {
    if(firebaseUser != null){
      User user = firebaseUser.isAnonymous
        ? User.newUser()
        : await get(firebaseUser.displayName);
      user.firebaseUser = firebaseUser;
      return user;
    }
    else{
      return null;
    }
  }

  /// Gets the current firebase user and assigns it to the user model
  /// Can return null if there is an issue getting the user,
  /// i.e. if the firebase user is anonymous they will not have a user
  /// Tries to retrieve from cache first, otherwise from firebase
  Future<User> getCurrentUser({FirebaseUser firebaseUser}) async {
    try {
      User user = _userCache.tryGet();
      if(user == null){
        firebaseUser = firebaseUser ?? await authAPI.currentUser();
        user = await _getUser(firebaseUser: firebaseUser);
      }

      return user;
    } catch (e, st) {
      FirestoreExceptionHandler.tryGetMessage(e, st);
      signOut();
      return null;
    }
  }

  Future<bool> isAnonymous({FirebaseUser firebaseUser}) async {
    try{
      return await authAPI.isAnonymous(firebaseUser: firebaseUser);
    }
    catch(e, st){
      FirestoreExceptionHandler.tryGetMessage(e, st);
      return false;
    }
  }

  Future<void> resetPassword({@required String email}) async {
    await authAPI.resetPassword(email: email);
  }

  Future<AuthResult> signInAnonymously() async {
    return authAPI.signInAnonymously();
  }

  Future<AuthResult> signInWithGoogle() async {
    final GoogleSignInAccount googleAccount = await authAPI.googleSignIn();
    if (googleAccount != null) {
      AuthCredential credential = authAPI.getCredentialFromGoogleAuth(
          googleSignInAuthentication: await googleAccount.authentication);
      return await authAPI.signInWithCredentials(credential);
    }

    return Future.error('Google sign in cancelled');
  }

  Future<AuthResult> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    return authAPI.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<bool> get isEmailVerified => authAPI.isEmailVerified();

  Future<String> get nickname async {
    final user = await getCurrentUser();
    if (user == null) {
      bool userAnonymous = await isAnonymous();
      if (userAnonymous) {
        return 'Anonymous';
      } else {
        return 'Error';
      }
    } else {
      return user.firebaseUser.displayName;
    }
  }

  Future<bool> registerWithEmailAndPassword(
      {@required String nickname,
      @required String email,
      @required String password}) async {

    AuthResult authResult = await authAPI.createUserWithEmailAndPassword(
        email: email, password: password);
    if (authResult != null) {
      await createNewUser(authResult.user, nickname, sendEmailVerification: true);
      return true;
    }

    return false;
  }

  /// Creates a new user to go along with the recently created firebaseUser
  /// This also creates all associated data initially needed for the user to navigate the app
  Future<User> createNewUser(FirebaseUser firebaseUser, String nickname, {bool sendEmailVerification = false}) async {
    firebaseUser = await setFirebaseUserFields(firebaseUser: firebaseUser, displayName: nickname);

    if(sendEmailVerification){
      firebaseUser.sendEmailVerification();
    }

    User user = await _createUser(firebaseUser);
    await locator<FirebaseSettingsRepository>().addNewUserSettings(user);

    return user;
  }

  /// Updates the firebaseUser properties specified and returns an instance with those updates
  /// If no firebaseUser is specified, the current session instance is retrieved.
  Future<FirebaseUser> setFirebaseUserFields({FirebaseUser firebaseUser, String displayName, String photoUrl}) async {
    if(firebaseUser == null){
      firebaseUser = await getAuthUser();
    }

    await _updateFirebaseUserInfo(firebaseUser, displayName: displayName, photoUrl: photoUrl);

    return await getAuthUser();
  }

  Future<void> _updateFirebaseUserInfo(FirebaseUser user, {String displayName, String photoUrl}) async {
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    if(displayName != null){
      userUpdateInfo.displayName = displayName;
    }

    if(photoUrl != null){
      userUpdateInfo.photoUrl = photoUrl;
    }

    return user.updateProfile(userUpdateInfo);
  }

  Future<bool> isSignedIn(FirebaseUser firebaseUser) async {
    if(firebaseUser == null){
      firebaseUser = await authAPI.currentUser();
    }

    return firebaseUser != null;
  }

  Future<void> signOut() async {
    return Future.wait([
      authAPI.signOut(),
      authAPI.googleSignOut(),
    ]);
  }

  Future<User> _createUser(FirebaseUser firebaseUser) async {
    User user = User.newUser()
      ..firebaseUser = firebaseUser;

    _userCache.addData(user);

    return await add(user);
  }

  static Map<UserFields, String> dbFieldNames = Map.fromIterable(
    UserFields.values,
    key: (userField) => userField,
    value: (userField) => _getDbFieldNames(userField)
  );

  static String _getDbFieldNames(UserFields userField){
    switch (userField) {
      case UserFields.createdTime:
        return 'ct';
      case UserFields.friendIDs:
        return 'fs';
      case UserFields.completedIntro:
        return 'ci';
      case UserFields.careerID:
        return 'c';
      case UserFields.isAdmin:
        return 'ad';
      default:
        locator<Logging>().log(LogType.pretty, LogLevel.error, 'No UserField mapping found in dbFieldNames for $userField');
        return null;
    }
  }
}