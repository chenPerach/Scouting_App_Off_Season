import 'package:firebase_auth/firebase_auth.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';

import 'auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static FirebaseAuthService instance = FirebaseAuthService();
  User get user => _firebaseAuth.currentUser;
  static FirebaseAuthService getInstance() {
    return instance;
  }

  Stream<User> get userChanges => _firebaseAuth.userChanges();
  @override
  Future<PrimoUser> createUserWithEmailAndPassword(
      String email, String password,
      {String name, String photoUrl}) async {
    UserCredential result;
    try {
      result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          throw AuthException(message: "the password is to weak");
          break;
        case "email-already-in-use":
          throw AuthException(message: "email already in use");
          break;
        case "invalid-email":
          throw AuthException(message: "email not valid");
          break;
        case "weak-password":
          throw AuthException(message: "password is too weak");
          break;
      }
    } catch (e) {}
    User u = result.user;
    await u.updateDisplayName(name);
    // await u.updateProfile(displayName: name, photoURL: photoUrl);

    return toPrimoUser(u);
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

  PrimoUser toPrimoUser(User u) =>
      PrimoUser(user: u, favoriteTeams: PrimoUserService.initialFav);
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
  Future<PrimoUser> signInWithEmailAndLink({String email, String link}) async {
    UserCredential result =
        await _firebaseAuth.signInWithEmailLink(email: email, emailLink: link);
    return toPrimoUser(result.user);
  }

  @override
  Future<PrimoUser> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential result;
    try {
      print("signing in with mail");
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Failed to login with error code: ${e.code}");
      throw AuthException(message: "wrong email or password!");
    } catch (e) {}
    return toPrimoUser(result.user);
  }

  @override
  void signOut() {
    _firebaseAuth.signOut();
  }
}

final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
