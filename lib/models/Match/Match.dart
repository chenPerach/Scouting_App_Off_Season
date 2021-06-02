import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:scouting_app_2/models/AllianceModel.dart';

class Match {
  CompLevel compLevel;
  int matchNumber;
  int teamNumber;
  String alliance;
  Match({
    @required this.compLevel,
    @required this.matchNumber,
    @required this.teamNumber,
    @required this.alliance,
  });

  factory Match.formJson(Map<String, dynamic> json) {
    return Match(
      compLevel: CompLevel.simple(json["comp_level"]),
      matchNumber: json["match_number"],
      teamNumber: json["team_number"],
      alliance: json["alliance"]
    );
  }
  factory Match.empty() {
    return Match(
      compLevel: CompLevel.simple("qm"),
      matchNumber: 0,
      teamNumber: 4586,
      alliance: "red",
    );
  }

  /// creates a copy of this object
  /// the [=] parameter only passes a [reference] around
  /// and does not create a new member in memory
  Match clone() {
    return Match(
        compLevel: CompLevel.simple(this.compLevel.compLevel),
        matchNumber: this.matchNumber);
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
    // ignore: test_types_in_equals
    return (other as CompLevel).compLevel == this.compLevel &&
        (other as CompLevel).compLevelDetailed == this.compLevelDetailed;
  }

  @override
  int get hashCode => super.hashCode;
}
