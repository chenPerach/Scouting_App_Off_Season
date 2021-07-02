import 'package:scouting_app_2/models/Match/GameInfo.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/Match/PostGameData.dart';
import 'package:scouting_app_2/models/model.dart';

///this class holds all the data a match could have
///it exists to hold all the data, the data is seperated to different classes to
/// improve readability and code managment
class ScoutingMatch extends Model {
  DateTime time;
  GameInfo info;
  ScoutingMatchData data;
  PostGameData postGameData;
  ScoutingMatch({this.data, this.info, this.time}) {
    if (this.time == null) this.time = DateTime.now();
  }

  factory ScoutingMatch.formJson(Map<String, dynamic> json) {
    return ScoutingMatch(
        time: DateTime.fromMillisecondsSinceEpoch(json["time"]),
        data: ScoutingMatchData.fromJson(Map.from(json["data"])),
        info: GameInfo.fromJson(Map.from(json["general_info"])));
  }

  /// creates a copy of this object
  /// the [=] parameter only passes a [reference] around
  /// and does not create a new member in memory

  Map<String, dynamic> toJson() {
    return {
      "general_info": info.toJson(),
      "data": data.toJson(),
      "time": time.millisecondsSinceEpoch
    };
  }
}


