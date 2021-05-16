import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static FirebaseAuthService instance = FirebaseAuthService();
  User get user => _firebaseAuth.currentUser;
  static FirebaseAuthService getInstance() {
    return instance;
  }
  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,
      {String name, String photoUrl}) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((e) => print(e));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          throw AuthExeption("the password is to weak");
          break;
        case "email-already-in-use":
          throw AuthExeption("email already in use");
          break;
        case "invalid-email":
          throw AuthExeption("email not valid");
          break;
        case "weak-password":
          throw AuthExeption("password is too weak");
          break;
      }
    }
  }

  @override
  Stream<User> authState() => _firebaseAuth.authStateChanges();
  @override
  void dispose() {}

  @override
  Future<bool> isSignInWithEmailLink(String link) async {
    return await isSignInWithEmailLink(link);
  }

  @override
  void sendPasswordResetEmail(String email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  void sendSignInWithEmailLink(
      {String email,
      String url,
      bool handleCodeInApp,
      String iOSBundleID,
      String androidPackageName,
      bool androidInstallApp,
      String androidMinimumVersion}) {
    _firebaseAuth.sendSignInLinkToEmail(
      actionCodeSettings: ActionCodeSettings(
          url: url,
          iOSBundleId: iOSBundleID,
          androidInstallApp: androidInstallApp,
          androidPackageName: androidPackageName,
          androidMinimumVersion: androidMinimumVersion,
          handleCodeInApp: handleCodeInApp),
      email: email,
    );
  }

  @override
  Future<User> signInWithEmailAndLink({String email, String link}) async {
    UserCredential result =
        await _firebaseAuth.signInWithEmailLink(email: email, emailLink: link);
    return result.user;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result;
    try {
      print("signing in with mail");
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch(e) {
      print("Failed to login with error code: ${e.code}");
      throw AuthExeption("wrong email or password!");
    } on PlatformException catch (e) {
      print("User does not exist");
    }
    return result.user;
  }

  @override
  void signOut() {
    _firebaseAuth.signOut();
  }
}

final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
