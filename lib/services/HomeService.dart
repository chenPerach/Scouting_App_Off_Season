import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class HomeService {
  static var ref = FirebaseDatabase.instance.reference().child("matches");
  static Future<List<MatchModel>> getMatches() async {
    var raw_data = await ref.once();
    List matches = raw_data.value;
    List<MatchModel> list = [];
    matches.forEach((element) =>
        list.add(MatchModel.fromJson(Map<String,dynamic>.from(element))));
    return list;
  }
}
