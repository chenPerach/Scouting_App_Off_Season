import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/main.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class HomeService {
  static var ref = FirebaseDatabase.instance.reference().child(branch).child("matches");
  static List<MatchModel> matchList = [];
  static Future<List<MatchModel>> getMatches() async {
    var rawData = await ref.once();
    List matches = rawData.value;
    if(matches == null) return null;
    
    List<MatchModel> list = [];
    matches.forEach((element) =>
        list.add(MatchModel.fromJson(Map<String, dynamic>.from(element))));
    matchList = List<MatchModel>.from(list);
    return list;
  }
}
