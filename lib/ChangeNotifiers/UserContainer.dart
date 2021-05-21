import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class UserContainer extends ChangeNotifier {
  PrimoUser _user;
  static StreamSubscription<User> _subscription;
  UserContainer() {
    _subscription = FirebaseAuthService.instance.userChanges.listen((user) {
      if (user == null) return;
      _syncWithDB(user).then((value) {
        _user = value;
        notifyListeners();
      });
    });
  }
  set user(PrimoUser user) {
    this._user = user;
    notifyListeners();
  }

  void setUpChangeListener() {
    PrimoUserService.addListener(_user,(e) {
      print("USER CONTAINER: notifying user ${_user.user?.displayName ?? "loading..."}");
      PrimoUserService.handleSnapShot(_user, e.snapshot); 
      notifyListeners();
    });
  }

  PrimoUser get user => this._user;
  static void cancelSubscription(){
    _subscription.cancel();
  }
  Future<PrimoUser> _syncWithDB(User user) async {
    var puser = await PrimoUserService.getUser(user);
    if (puser == null) {
      puser = FirebaseAuthService.instance.toPrimoUser(user);
      await PrimoUserService.updateUser(puser);
    }
    return puser;
  }
}
