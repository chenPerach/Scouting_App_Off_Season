import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/Team.dart';

class PrimoUser {
  User user;
  Map<int, bool> favorites;
  PrimoUser({this.favorites, this.user});
}

class PrimoUserService {
  static DatabaseReference _usersRef =
      FirebaseDatabase.instance.reference().child("users");
  static Map<int, bool> initial_fav = Map.fromIterable(TeamsConsts.teams_json,
      key: (e) => e["number"], value: (e) => false);

  static Future<PrimoUser> getUser(User user) async {
    var _userRef = _usersRef.child(user.uid);
    var snapshot = await _userRef.once();
    if (snapshot.value == null) return null;

    return PrimoUser(
        user: user,
        favorites: Map<int,bool>.fromIterable(
            Map<String, bool>.from(snapshot.value["favorites"]).entries,
            key: (e) => int.parse(e.key),
            value: (e) => e.value));
  }

  static PrimoUser getUserFromSnapShot(User user,DataSnapshot snapshot){
    return PrimoUser(
        user: user,
        favorites: Map<int,bool>.fromIterable(
            Map<String, bool>.from(snapshot.value).entries,
            key: (e) => int.parse(e.key),
            value: (e) => e.value));
  }

  static Future<void> addUser(PrimoUser user) async {
    var _userRef = _usersRef.child(user.user.uid);
    if(user.user.displayName == null) return null;
    await _userRef.update({
      "name": user.user.displayName,
      "favorites": Map<String, bool>.fromIterable(user.favorites.entries,
          key: (item) => item.key.toString(), value: (e) => e.value)
    });
  }

  static addListener(PrimoUser user, void onData(Event e),
      {void onError(), void onDone()}) {
    var _userRef = _usersRef.child(user.user.uid);
    _userRef.onChildChanged.listen(onData, onError: onError, onDone: onDone);
  }
}
