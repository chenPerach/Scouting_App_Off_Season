import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:uuid/uuid.dart';

class ScoutingDataService {
  static var _ref = FirebaseDatabase.instance.reference();
  static var uuid = Uuid();
  static Future<void> uploadMatch(ScoutingMatch match,PrimoUser user) async {
    var submittionTime = DateTime.now();
    var id = uuid.v1();
    var userId = user.user.uid;
    var userRef = _ref.child("users/$userId/posts/$id");
    var teamRef = _ref.child("teams/${match.info.teamNumber}/posts/$id");
    var posts = _ref.child("posts/$id");
    await userRef.set(submittionTime.millisecondsSinceEpoch);
    await teamRef.set(submittionTime.millisecondsSinceEpoch);
    await posts.set(match.toJson());
  }

  static Future<List<ScoutingMatch>> fetchMatches(List<String> ids)async{
    List<ScoutingMatch> matches = [];
    ids.forEach((e) async {
      var snapshot = await _ref.child("posts/$e").once();
      matches.add(ScoutingMatch.formJson(snapshot.value));
    });
    return matches;
  } 
}