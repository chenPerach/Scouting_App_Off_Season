import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class HomeService {
  static var ref = FirebaseDatabase.instance.reference().child("matches");
  static Future<List<MatchModel>> getMatches() async {
    var rawData = await ref.once();
    List matches = rawData.value;
    List<MatchModel> list = [];
    matches.forEach((element) =>
        list.add(MatchModel.fromJson(Map<String,dynamic>.from(element))));
    return list;
  }
}
