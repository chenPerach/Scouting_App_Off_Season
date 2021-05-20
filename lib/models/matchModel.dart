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
      red_allience: Allience.fromJson(List<String>.from(json["alliances"]["red"]["team_keys"]), "red"),
      blue_allience: Allience.fromJson(List<String>.from(json["alliances"]["blue"]["team_keys"]), "blue"),
    );
  }
  String toString(){
    print("number: $matchNumber");
    print("number: $compLevel");
    print("blue ${blue_allience.teamNumbers}");
    print("blue ${red_allience.teamNumbers}");
  }
}
