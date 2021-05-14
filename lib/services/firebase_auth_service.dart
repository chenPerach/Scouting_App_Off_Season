import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:scouting_app_off_season/services/auth_service.dart';


class FirebaseAuthService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static FirebaseAuthService instance = FirebaseAuthService();

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) return null;
    return User(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoUrl);
  }

  Future<User> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(String email, String password,
      {String name, String photoUrl}) async {
    AuthResult result = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((e) => print(e));
    UserUpdateInfo info = UserUpdateInfo();
    if (name != null) info.displayName = name;
    if (photoUrl != null) info.photoUrl = photoUrl;
    await result.user.updateProfile(info);
    await result.user.reload();
    return await currentUser();
  }

  @override
  void dispose() {}

  @override
  Future<bool> isSignInWithEmailLink(String link) async {
    return await isSignInWithEmailLink(link);
  }

  @override
  Stream<User> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map((event) => _userFromFirebase(event));

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
      bool androidInstallIfNotAvailable,
      String androidMinimumVersion}) {
    _firebaseAuth.sendSignInWithEmailLink(
        email: email,
        url: url,
        handleCodeInApp: handleCodeInApp,
        iOSBundleID: iOSBundleID,
        androidPackageName: androidPackageName,
        androidInstallIfNotAvailable: androidInstallIfNotAvailable,
        androidMinimumVersion: androidMinimumVersion);
  }

  @override
  Future<User> signInWithEmailAndLink({String email, String link}) async {
    AuthResult result =
        await _firebaseAuth.signInWithEmailAndLink(email: email, link: link);
    return _userFromFirebase(result.user);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult result;
    try {
      print("signing in with mail");
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (PlatformException) {
      throw Exception("unable to login");
    }
    return _userFromFirebase(result.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    GoogleSignIn  googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleAccount;
    try{
       googleAccount = await googleSignIn.signIn();
    }catch(e){
      print(e);
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: "user aborted google sign in");
    }

    if (googleAccount == null)
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: "user aborted google sign in");

    GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    if (googleAuth.accessToken == null && googleAuth.idToken == null)
      throw PlatformException(
          code: 'GOOGLE_AUTH_TOKEN_ID_ERROR',
          message: "missing google authentication token");

    AuthResult result = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
    return _userFromFirebase(result.user);
  }

  @override
  void signOut() {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    _firebaseAuth.signOut();
  }
}

final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
