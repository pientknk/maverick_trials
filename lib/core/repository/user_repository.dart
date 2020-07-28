import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maverick_trials/core/models/user.dart';
import 'package:maverick_trials/core/repository/repository.dart';
import 'package:maverick_trials/core/services/firestore_api.dart';

class UserRepository extends Repository {
  User _currentUser;

  Future<User> addUser(User user) async {
    DocumentReference userRef =
        await dbAPI.addDocument(FirestoreAPI.usersCollection, user.toJson());
    DocumentSnapshot userSnapshot = await userRef.get();
    return User.fromJson(userSnapshot.data);
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
        FirestoreAPI.usersCollection, 'UUID', uid);
    DocumentSnapshot userSnapshot = snapshot.documents.first;
    return User.fromJson(userSnapshot.data);
  }

  Future<User> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }

    String currentUserUid = await authAPI.currentUserUid();
    _currentUser = await getUserByUID(uid: currentUserUid);

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

  String getErrorMsgForCode(String code) {
    switch (code) {
      case 'ERROR_INVALID_EMAIL':
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
        return 'Incorrect email and or Password';
        break;
      case 'ERROR_USER_DISABLED':
        return 'Please try again later';
        break;
      case 'ERROR_TOO_MANY_REQUESTS':
        return 'You have entered too many incorrect email/password combinations. Try again later';
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'Login via email and password is currently not allowed';
        break;
      case 'ERROR_LOGIN_GOOGLE':
        return 'Unable to log in using Google';
        break;
      default:
        return 'Error: $code';
        break;
    }
  }

  Future<bool> get isEmailVerified => authAPI.isEmailVerified();

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
      return true;
    }

    return false;
  }

  Future<bool> isSignedIn() async {
    final FirebaseUser currentUser = await authAPI.currentUser();

    return currentUser != null;
  }

  //TODO: eventually this should be used to populate the user model with useful info
  Future<String> getAuthUser() async {
    return (await authAPI.currentUser())?.email;
  }

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'Token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken() async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1));
    return false;
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
}
