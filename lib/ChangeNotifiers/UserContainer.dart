import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class UserContainer extends ChangeNotifier {
  PrimoUser _user;

  UserContainer() {
    FirebaseAuthService.instance.userChanges.listen((user) {
      if (user == null) return;
      _syncWithDB(user).then((value) {
        _user = value;

        notifyListeners();
      });
    });
    // FirebaseAuthService.instance.authState().listen((e) {
    //   if (e != null)
    //     PrimoUserService.addListener(_user, (e) {
    //       _user = PrimoUserService.getUserFromSnapShot(_user.user, e.snapshot);
    //       notifyListeners();
    //     });
    // });
  }
  set user(PrimoUser user) {
    this._user = user;
    notifyListeners();
  }

  void setUpChangeListener(PrimoUser puser) {
    PrimoUserService.addListener(puser, (e) {
      print("USER CONTAINER: notifying user ${puser.user.displayName}");
      /**
       * the [snapshot] object returns a different key depending on what has been 
       * changed. [remember to handle that!!!]
       */
      if(e.snapshot.key == "favorites"){
        _user.favorites = Map<int,bool>.fromIterable(e.snapshot.value.entries,key: (e)=>int.parse(e.key),value: (e)=>e.value);
      }
      notifyListeners();
      print(_user.favorites);
    });
  }

  PrimoUser get user => this._user;

  Future<PrimoUser> _syncWithDB(User user) async {
    var puser = await PrimoUserService.getUser(user);
    if (puser == null) {
      puser = FirebaseAuthService.instance.toPrimoUser(user);
      await PrimoUserService.addUser(puser);
    }
    return puser;
  }
}
