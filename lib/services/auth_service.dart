import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthService {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  void sendPasswordResetEmail(String email);
  Future<User> signInWithEmailAndLink({String email, String link});
  Future<bool> isSignInWithEmailLink(String link);
  void sendSignInWithEmailLink({
    @required String email,
    @required String url,
    @required bool handleCodeInApp,
    @required String iOSBundleID,
    @required String androidPackageName,
    @required bool androidInstallApp,
    @required String androidMinimumVersion,
  });
  // Future<User> signInWithGoogle();
  void signOut();
  void dispose();

  Stream<User> authState();
}

class AuthException implements Exception {
  String message, happendOn, description;
  AuthException({this.message,this.happendOn,this.description});
}
