import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class UserContainer extends ChangeNotifier {
  User _user;

  UserContainer() {
    FirebaseAuthService.instance.userChanges.listen((user) {
      this.user = user;
    });
  }
  set user(User user) {
    this._user = user;
    notifyListeners();
  }

  User get user => this._user;
}
