import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/Utils/StreamHandler.dart';
import 'package:scouting_app_2/main.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:uuid/uuid.dart';

class ScoutingDataService {
  static var _ref = FirebaseDatabase.instance.reference().child(branch);
  static AnsiPen _pen = AnsiPen()
    ..cyan(bg: false, bold: true)
    ..black(bg: true);
  static String _kTAG = "SCOUTING DATA SERVICE";
  static var uuid = Uuid();
  static Set<MapEntry<String, ScoutingMatch>> scoutingMatches = Set();
  static StreamHandler _streams = StreamHandler();

  static void init() {
    addSubscription(_ref.child("posts").onChildAdded.listen((event) {
      var snap = event.snapshot;

      _log("handling the addition of data to /posts, ${snap.key}");
      var m = Map<String, dynamic>.from(snap.value);

      scoutingMatches
          .add(MapEntry(event.snapshot.key, ScoutingMatch.formJson(m)));
    }));
  }

  static void calculateStatistics() {
    var teams = TeamsConsts.teams;

    for (var m in scoutingMatches) {
      int number = m.value.info.teamNumber;

      teams.where((e) => e.number == number).first.matches.add(m.value);
    }

    for (var team in teams) {
      team.createStatistics();
    }
  }

  static Future<void> uploadMatch(ScoutingMatch match, PrimoUser user) async {
    var submittionTime = DateTime.now();
    var id = uuid.v1();
    var userId = user.user.uid;
    var userRef = _ref.child("users/$userId/posts/$id");
    var teamRef = _ref.child("teams/${match.info.teamNumber}/posts/$id");
    var posts = _ref.child("posts/$id");
    userRef.set(submittionTime.millisecondsSinceEpoch);
    teamRef.set(submittionTime.millisecondsSinceEpoch);
    posts.set(match.toJson());
  }

  static Future<List<ScoutingMatch>> fetchMatches(List<String> ids) async {
    List<ScoutingMatch> matches = [];
    ids.forEach((e) async {
      var snapshot = await _ref.child("posts/$e").once();
      matches.add(ScoutingMatch.formJson(snapshot.value));
    });
    return matches;
  }

  static void addSubscription(StreamSubscription sub) {
    _streams.addStream(sub);
  }

  static void clearStreamSubscriptions() {
    _log("$_kTAG: clearing stream subscriptions");
    _streams.cancelAll();
  }

  static void _log(String msg) {
    print(_pen("$_kTAG: $msg"));
  }
}
