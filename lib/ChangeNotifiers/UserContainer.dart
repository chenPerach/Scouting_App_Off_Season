import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

//this is a test
class UserContainer extends ChangeNotifier {
  PrimoUser _user;
  static StreamSubscription<User> _subscription;
  UserContainer() {
    _subscription =
        FirebaseAuthService.instance.userChanges.listen((user) async {
      if (user == null || user.displayName == null) return;
      _user = await _syncWithDB(user);
      notifyListeners();
    });
  }
  set user(PrimoUser user) {
    this._user = user;
    notifyListeners();
  }

  void setUpChangeListener() {
    PrimoUserService.addListener(_user, (e) {
      PrimoUserService.handleSnapShot(_user, e.snapshot);
      notifyListeners();
    });
  }

  PrimoUser get user => this._user;
  static void cancelSubscription() {
    _subscription.cancel();
  }

  Future<PrimoUser> _syncWithDB(User user) async {
    var puser = await PrimoUserService.getUser(user);
    if (puser == null) {
      puser = FirebaseAuthService.instance.toPrimoUser(user);
      PrimoUserService.updateUser(puser)
          .then((value) => print("finished updating!"));
    }
    return puser;
  }
}
