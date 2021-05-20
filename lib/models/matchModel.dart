import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/AllianceModel.dart';
import 'package:scouting_app_2/models/Team.dart';

class MatchModel {
  int matchNumber;
  String compLevel;
  DateTime time;
  Allience red_allience, blue_allience;

  MatchModel(
      {@required this.red_allience,
      @required this.blue_allience,
      @required this.compLevel,
      @required this.matchNumber,
      @required this.time});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      compLevel: json["comp_level"],
      matchNumber: json["match_number"],
      time: DateTime.fromMillisecondsSinceEpoch(json["time"]),
      red_allience: Allience.fromJson(json["alliences"]["red"], "red"),
      blue_allience: Allience.fromJson(json["alliences"]["blue"], "blue"),
    );
  }
}
