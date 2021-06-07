import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:scouting_app_2/models/Match/CompLevel.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/model.dart';

///this class holds all the data a match could have
///it exists to hold all the data, the data is seperated to different classes to
/// improve readability and code managment
class ScoutingMatch extends Model {
  CompLevel compLevel;
  int matchNumber;
  int teamNumber;
  String alliance;
  // String startingPosition;
  ScoutingMatchData data;
  ScoutingMatch({
    @required this.compLevel,
    @required this.matchNumber,
    @required this.teamNumber,
    @required this.alliance,
  }) {
    this.data = ScoutingMatchData();
  }

  factory ScoutingMatch.formJson(Map<String, dynamic> json) {
    return ScoutingMatch(
      compLevel: CompLevel.simple(json["comp_level"]),
      matchNumber: json["match_number"],
      teamNumber: json["team_number"],
      alliance: json["alliance"],
    );
  }

  /// creates a copy of this object
  /// the [=] parameter only passes a [reference] around
  /// and does not create a new member in memory
  ScoutingMatch clone() {
    return ScoutingMatch(
      compLevel: CompLevel.simple(this.compLevel.simple),
      matchNumber: this.matchNumber,
      teamNumber: this.teamNumber,
      alliance: this.alliance,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "alliance": alliance,
      "team_number": this.teamNumber,
      "comp_level": this.compLevel.simple,
      "data": this.data.toJson(),
    };
  }
}
