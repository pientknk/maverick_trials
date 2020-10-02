import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Firebase Authentication Instance
  FirebaseAuth getFirebaseAuth() {
    return _firebaseAuth;
  }

  Future<FirebaseUser> currentUser() async {
    return _firebaseAuth.currentUser();
  }

  Future<String> currentUserUid() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  //possibly return the exception or null if no exception
  Future<void> resetPassword({@required String email}) async {
    _firebaseAuth.sendPasswordResetEmail(email: email).catchError((onError) {
      if (onError is PlatformException) {
        print('Reset Password Error: ${onError.message}');
      }
    });
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithCredentials(AuthCredential credential) async {
    _firebaseAuth.signInWithCredential(credential).catchError((e) {
      print(e);
      //Future.error(e);
    });
  }

  Future<void> signInAnonymously() async {
    return _firebaseAuth.signInAnonymously();
  }

  Future<AuthResult> createUserWithEmailAndPassword(
      {@required String email, @required String password}) async {
    try {
      AuthResult authResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      authResult.user.sendEmailVerification();
      //_firebaseAuth.signOut();
      return authResult;
    } catch (e) {
      print(e);
      return Future.error('Unable to create user with email and password');
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user == null ? false : user.isEmailVerified;
  }

  Future<bool> isAnonymous() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user == null ? false : user.isAnonymous;
  }

  Future<String> userProvider() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user == null ? "None" : user.providerId;
  }

  /// Google
  GoogleSignIn getGoogleSignIn() {
    return _googleSignIn;
  }

  Future<GoogleSignInAccount> googleSignIn() async {
    return _googleSignIn.signIn();
  }

  AuthCredential getCredentialFromGoogleAuth(
      {@required GoogleSignInAuthentication googleSignInAuthentication}) {
    return GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
  }

  Future<void> googleSignOut() {
    return _googleSignIn.signOut();
  }
}
