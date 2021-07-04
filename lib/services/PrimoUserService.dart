import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/main.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';
import 'package:scouting_app_2/services/gameForm.dart';

class PrimoUserService {
  static AnsiPen _pen = AnsiPen()..yellow(bold: true, bg: false);
  static const String _TAG = "PRIMO USER SERVICE";
  static DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child(branch).child("users");
  static List<StreamSubscription> _streamSubs = [];
  static final Map<int, bool> initialFav = Map.fromIterable(
      TeamsConsts.teams_json,
      key: (e) => e["number"],
      value: (e) => false);

  static Future<PrimoUser> getUser(User user) async {
    _log("$_TAG: getting user from firebase");
    var _userRef = _usersRef.child(user.uid);
    var snapshot = await _userRef.once().catchError((error, stackTrace) {
      _log(error);
      _log(stackTrace.toString());
      return null;
    });
    _log("$_TAG: aquired snapshot from data base");
    if (snapshot.value == null) {
      _log("$_TAG: wasn't able to get firebase user.");
      return null;
    }

    var puser = PrimoUser(
        user: user,
        favoriteTeams: Map<int, bool>.fromIterable(
            Map<String, bool>.from(snapshot.value["favorite_teams"]).entries,
            key: (e) => int.parse(e.key),
            value: (e) => e.value),
        isAdmin: snapshot.value["admin"]);
    puser.favoriteMatches =
        List<int>.from(snapshot.value["favorite_matches"] ?? [-1]);
    return puser;
  }

  static Future<void> updateUser(PrimoUser user) async {
    _log("$_TAG: adding user to data base");
    var _userRef = _usersRef.child(user.user.uid);
    if (user.user.displayName == null) return;
    await _userRef.update({
      "name": user.user.displayName,
      "favorite_teams": Map<String, bool>.fromIterable(
          user.favoriteTeams.entries,
          key: (item) => item.key.toString(),
          value: (e) => e.value),
      "admin": user.isAdmin,
    }).catchError((error, stackTrace) {
      _log("$_TAG: wasn't able to get user");
      _log(stackTrace.toString());
    });
    if (user.favoriteMatches.isNotEmpty)
      await _userRef.child("favorite_matches").set(user.favoriteMatches);
  }

  static addListener(PrimoUser user, void onData(Event e),
      {void onError(msg), void onDone()}) {
    var _userRef = _usersRef.child(user.user.uid);

    _streamSubs.add(_userRef.onChildChanged
        .listen(onData, onError: onError, onDone: onDone));
  }

  static void clearStreamSubscriptions() {
    _log("$_TAG: clearing stream subscriptions");
    _streamSubs.forEach((e) => e.cancel());
    _streamSubs = [];
  }

  static void handleSnapShot(PrimoUser user, DataSnapshot snapshot) {
    _log("$_TAG: handling database change on user ${user.user.displayName}");
    /**
     * the [snapshot] object returns a different key depending on what has been 
     * changed. [remember to handle that!!!]
     */
    if (snapshot.key == "favorites") {
      user.favoriteTeams = Map<int, bool>.fromIterable(snapshot.value.entries,
          key: (e) => int.parse(e.key), value: (e) => e.value);
    }
  }

  static void signOut() {
    _log("$_TAG: signing out, see ya!");
    clearStreamSubscriptions();
    ScoutingDataService.clearStreamSubscriptions();
    FirebaseAuthService.instance.signOut();
  }

  static void addSubscription(StreamSubscription sub) {
    _streamSubs.add(sub);
  }

  static void _log(String msg) {
    print(_pen(msg));
  }
}
