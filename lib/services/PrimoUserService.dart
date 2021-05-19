import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class PrimoUserService {
  static AnsiPen pen = AnsiPen()..yellow(bold: true,bg: false);
  static const String _TAG = "PRIMO USER SERVICE";
  static DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child("users");
  static List<StreamSubscription> streamSubs = [];
  static Map<int, bool> initial_fav = Map.fromIterable(TeamsConsts.teams_json,
      key: (e) => e["number"], value: (e) => false);

  static Future<PrimoUser> getUser(User user) async {
    _log("$_TAG: getting user from firebase");
    var _userRef = _usersRef.child(user.uid);
    var snapshot = await _userRef.once();
    if (snapshot.value == null) {
      _log("$_TAG: wasn't able to get firebase user.");
      return null;
    }

    return PrimoUser(
        user: user,
        favorites: Map<int, bool>.fromIterable(
            Map<String, bool>.from(snapshot.value["favorites"]).entries,
            key: (e) => int.parse(e.key),
            value: (e) => e.value));
  }

  static Future<void> addUser(PrimoUser user) async {
    _log("$_TAG: adding user to data base");
    var _userRef = _usersRef.child(user.user.uid);
    if (user.user.displayName == null) return null;
    await _userRef.update({
      "name": user.user.displayName,
      "favorites": Map<String, bool>.fromIterable(user.favorites.entries,
          key: (item) => item.key.toString(), value: (e) => e.value)
    });
  }

  static addListener(PrimoUser user, void onData(Event e),
      {void onError(), void onDone()}) {
    var _userRef = _usersRef.child(user.user.uid);
    streamSubs.add(_userRef.onChildChanged
        .listen(onData, onError: onError, onDone: onDone));
  }

  static void clearStreamSubscriptions() {
    _log("$_TAG: clearing stream subscriptions");
    streamSubs.forEach((e) => e.cancel());
    streamSubs = [];
  }

  static void handleSnapShot(PrimoUser user, DataSnapshot snapshot) {
    _log("$_TAG: handling database change on user ${user.user.displayName}");
    /**
     * the [snapshot] object returns a different key depending on what has been 
     * changed. [remember to handle that!!!]
     */
    if (snapshot.key == "favorites") {
      user.favorites = Map<int, bool>.fromIterable(snapshot.value.entries,
          key: (e) => int.parse(e.key), value: (e) => e.value);
    }
  }

  static void signOut() {
    _log("$_TAG: signing out, see ya!");
    clearStreamSubscriptions();
    FirebaseAuthService.instance.signOut();
  }
  static void _log(String msg){
    print(pen(msg));
  }
}