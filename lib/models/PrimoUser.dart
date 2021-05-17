import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/Team.dart';

class PrimoUser {
  User _user;
  VoidCallback _notifier;
  DatabaseReference _userRef;
  List<Map<String, dynamic>> _favorites;
  PrimoUser(this._user) {
    this._favorites = PrimoUserConsts.favorites_initial;
    _notifier = () {};
    _userRef =
        FirebaseDatabase.instance.reference().child("users/${_user.uid}");
    _userRef.once().then((snapshot){
      snapshot.value["favorites"];
    });
    _userRef.onChildChanged.listen((event) {
      // if (event.snapshot.value == null) {
      //   _userRef.child("name").set(_user.displayName);
      //   _userRef.child("favorites").set(Map<Team, bool>.fromIterables( // these lines handle the favorite player's teams.
      //       TeamsConsts.teams,
      //       List.generate(TeamsConsts.teams.length, (index) => false)));
      //   _notifier.call();
      // }else{
      //   this._favorites = event.snapshot.value["favorites"];
      // }
    });
  }
  void changeFavorite(Team t){
    _favorites.;
  }
  User get firebaseUser => this._user;
  set notifier(VoidCallback notifier) => this._notifier = notifier;
}

class PrimoUserConsts {
  static List<Map<String, dynamic>> favorites_initial = List.generate(
      TeamsConsts.teams_json.length,
      (i) => TeamsConsts.teams_json[i].putIfAbsent("fav", () => false));
}
