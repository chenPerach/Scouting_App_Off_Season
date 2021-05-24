import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/models/AllianceModel.dart';

class MatchModel {
  int matchNumber;
  String compLevel;
  DateTime time;
  Allience redAllience, blueAllience;

  MatchModel(
      {@required this.redAllience,
      @required this.blueAllience,
      @required this.compLevel,
      @required this.matchNumber,
      @required this.time});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      compLevel: json["comp_level"],
      matchNumber: json["match_number"],
      time: DateTime.fromMillisecondsSinceEpoch(json["time"]),
      redAllience: Allience.fromJson(List<String>.from(json["alliances"]["red"]["team_keys"]), "red"),
      blueAllience: Allience.fromJson(List<String>.from(json["alliances"]["blue"]["team_keys"]), "blue"),
    );
  }
  String toString(){
    return "match: $matchNumber \n" + 
            "number: $compLevel \n" +
            "blue ${blueAllience.teamNumbers} \n" +
            "red ${redAllience.teamNumbers}";
  }
}
