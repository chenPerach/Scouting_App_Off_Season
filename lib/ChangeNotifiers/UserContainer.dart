import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class UserContainer extends ChangeNotifier {
  PrimoUser _user;

  UserContainer() {
    FirebaseAuthService.instance.userChanges.listen((user) {
      if(user == null) return;
      syncWithDB(user).then((value) {
        _user = value;
        notifyListeners();
      });
    });
  }
  set user(PrimoUser user) {
    this._user = user;
    notifyListeners();
  }

  PrimoUser get user => this._user;

  Future<PrimoUser> syncWithDB(User user) async {
    var puser = await PrimoUserService.getUser(user);
    if (puser == null) {
      puser = FirebaseAuthService.instance.toPrimoUser(user);
      await PrimoUserService.addUser(puser);
    }
    return puser;
  }
}
