import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:scouting_app_2/models/Match/CompLevel.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/model.dart';

///this class holds all the data a match could have
///it exists to hold all the data, the data is seperated to different classes to
/// improve readability and code managment
class ScoutingMatch extends Model {
  DateTime time;
  GameInfo info;
  ScoutingMatchData data;
  ScoutingMatch({this.data, this.info, this.time}) {
    if (this.time == null) this.time = DateTime.now();
  }

  factory ScoutingMatch.formJson(Map<String, dynamic> json) {
    return ScoutingMatch(
        time: DateTime.parse(json["time"]),
        data: ScoutingMatchData.fromJson(json["data"]),
        info: GameInfo.fromJson(json["general_info"]));
  }

  /// creates a copy of this object
  /// the [=] parameter only passes a [reference] around
  /// and does not create a new member in memory

  Map<String, dynamic> toJson() {
    return {
      "general_info": info.toJson(),
      "data": data.toJson(),
      "time": time.toUtc().toString()
    };
  }
}

class GameInfo extends Model {
  CompLevel compLevel;
  int matchNumber;
  int teamNumber;
  String alliance;
  GameInfo({this.alliance, this.compLevel, this.matchNumber, this.teamNumber});
  factory GameInfo.fromJson(Map<String, dynamic> json) => GameInfo(
      alliance: json["alliance"],
      teamNumber: json["team_number"],
      matchNumber: json["match_number"],
      compLevel: json["comp_level"]);

  @override
  Map<String, dynamic> toJson() {
    return {
      "comp_level": compLevel,
      "match_number": matchNumber,
      "alliance": alliance,
      "team_number": teamNumber
    };
  }
}
