import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/Utils/Extentions.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';
import 'package:scouting_app_2/models/model.dart';

/// [ScoutingMatchData] discribes the general data for what goes on in the match,
/// it holds data that is connected to the [teleop],[auto] and [end-game] stages of the match
class ScoutingMatchData extends Model {
  String startingPosition;
  EndGameStage endGame;
  MidGameStage autonomus, teleop;
  ScoutingMatchData(
      {this.startingPosition, this.autonomus, this.endGame, this.teleop});
  @override
  Map<String, dynamic> toJson() {
    return {
      "start_position": startingPosition,
      "auto": autonomus.toJson(),
      "teleop": teleop.toJson(),
      "end_game": endGame.toJson(),
    };
  }

  factory ScoutingMatchData.fromJson(Map<String, dynamic> json) =>
      ScoutingMatchData(
        startingPosition: json["start_position"],
        autonomus: MidGameStage.fromJson(json["auto"] == null ? null : Map<String,dynamic>.from(json["auto"])),
        teleop: MidGameStage.fromJson(json["teleop"] == null ? null : Map<String,dynamic>.from(json["teleop"])),
        endGame: EndGameStage.fromJson(Map<String,dynamic>.from(json["end_game"])),
      );
}

/// this class represents data for a single
/// [stage] in the game, i.e [autonumos],[end-game] or [teleop]
abstract class GenericScoutingStageData implements Model {}

class EndGameStage extends GenericScoutingStageData {
  EndGameClimbType type;
  EndGameStage({this.type});
  factory EndGameStage.fromJson(Map<String, dynamic> json) {
    return EndGameStage(type: EndGameClimbType.generate(json["type"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.value};
  }
}

class EndGameClimbType {
  static const String even = "EVEN",
      uneven = "UNEVEN",
      platform = "PLATFORM",
      empty = "NULL";
  String value;
  Image image;
  EndGameClimbType({this.image, this.value});
  factory EndGameClimbType.generate(String value) {
    Image img;
    switch (value) {
      case even:
        img = Image.asset("assets/images/EndGame/Balanced.png");
        break;
      case uneven:
        img = Image.asset("assets/images/EndGame/Climb.png");
        break;
      case platform:
        img = Image.asset("assets/images/EndGame/Park.png");
        break;
      case empty:
        img = Image.asset("assets/images/EndGame/Empty.png");
        break;
      default:
    }
    return EndGameClimbType(value: value, image: img);
  }
  num getScore() {
    switch (this.value) {
      case EndGameClimbType.empty:
        return 0;
        break;
      case EndGameClimbType.platform:
        return 5;
        break;
      case EndGameClimbType.uneven:
        return 25;
        break;
      case EndGameClimbType.even:
        return 40;
        break;
      default:
        return 0;
    }
  }
}

class MidGameStage extends GenericScoutingStageData {
  List<ShootingCycle> shooting;
  List<BallsCycle> balls;
  List<RolletCycle> rollet;

  MidGameStage({
    @required this.balls,
    @required this.rollet,
    @required this.shooting,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      "shooting_cycles":
          SmartList.fromIterable<Map<String, dynamic>, ShootingCycle>(
              shooting, (e) => e.toJson()),
      "balls_cycles": SmartList.fromIterable<Map<String, dynamic>, BallsCycle>(
          this.balls, (e) => e.toJson()),
      "rollet_cycles":
          SmartList.fromIterable<Map<String, dynamic>, RolletCycle>(
              this.rollet, (e) => e.toJson()),
    };
  }

  factory MidGameStage.fromJson(Map<String, dynamic> json) {
    
    var l =  json == null ? MidGameStage(balls: [],rollet: [],shooting: []) : MidGameStage(
      balls: json["balls_cycle"] == null ? [] : SmartList.fromIterable<BallsCycle, dynamic>(
          List.from(json["balls_cycles"]), (e) => BallsCycle.fromJson(Map<String,dynamic>.from(e))),
      shooting:json["shooting_cycles"] == null ? [] : SmartList.fromIterable<ShootingCycle, dynamic>(
          List.from(json["shooting_cycles"]), 
          (e) => ShootingCycle.fromJson(Map<String,dynamic>.from(e))),
      rollet: json["rollet_cycles"] == null ? [] :SmartList.fromIterable<RolletCycle,  dynamic>(
          List.from(json["rollet_cycles"]), (e) => RolletCycle.fromJson(Map<String,dynamic>.from(e))),
    );

    return l;
  }
}
