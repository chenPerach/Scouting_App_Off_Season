import 'package:flutter/cupertino.dart';
import 'package:scouting_app_off_season/Models/User.dart';



abstract class AuthService {
  Future<User> currentUser();
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
    @required bool androidInstallIfNotAvailable,
    @required String androidMinimumVersion,
  });
  Future<User> signInWithGoogle();
  void signOut();
  Stream<User> get onAuthStateChanged;
  void dispose();
}
