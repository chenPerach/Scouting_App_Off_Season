import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ScoutingMatch {
  CompLevel compLevel;
  int matchNumber;
  int teamNumber;
  String alliance;
  ScoutingMatch({
    @required this.compLevel,
    @required this.matchNumber,
    @required this.teamNumber,
    @required this.alliance,
  });

  factory ScoutingMatch.formJson(Map<String, dynamic> json) {
    return ScoutingMatch(
        compLevel: CompLevel.simple(json["comp_level"]),
        matchNumber: json["match_number"],
        teamNumber: json["team_number"],
        alliance: json["alliance"]);
  }
  factory ScoutingMatch.empty() {
    return ScoutingMatch(
      compLevel: CompLevel.simple("qm"),
      matchNumber: 0,
      teamNumber: 4586,
      alliance: "red",
    );
  }

  /// creates a copy of this object
  /// the [=] parameter only passes a [reference] around
  /// and does not create a new member in memory
  ScoutingMatch clone() {
    return ScoutingMatch(
      compLevel: CompLevel.simple(this.compLevel.compLevel),
      matchNumber: this.matchNumber,
      teamNumber: this.teamNumber,
      alliance: this.alliance,
    );
  }
}

@immutable
class CompLevel {
  final String compLevel;
  final String compLevelDetailed;
  CompLevel({this.compLevel, this.compLevelDetailed});

  factory CompLevel.simple(String compLevel) {
    String detailed;
    switch (compLevel) {
      case "qm":
        detailed = "Qualification Match";
        break;
      case "qf":
        detailed = "Quarter Finals";
        break;
      case "sf":
        detailed = "Semi Finals";
        break;
      case "f":
        detailed = "Finals";
        break;
      default:
    }
    return CompLevel(compLevel: compLevel, compLevelDetailed: detailed);
  }
  @override
  bool operator ==(Object other) {
    if(identical(this,other)) return true;
    return other is CompLevel && other.compLevel == this.compLevel &&
        other.compLevelDetailed == this.compLevelDetailed;
  }

  @override
  int get hashCode => super.hashCode;
}
