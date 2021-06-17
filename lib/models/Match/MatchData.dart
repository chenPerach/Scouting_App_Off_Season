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
  ScoutingMatchData({this.startingPosition}) {
    this.endGame = EndGameStage();
    this.autonomus = MidGameStage();
    this.teleop = MidGameStage();
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "start_position": startingPosition,
      "auto": autonomus.toJson(),
      "teleop": teleop.toJson(),
      "end_game": endGame.toJson(),
    };
  }
}

/// this class represents data for a single
/// [stage] in the game, i.e [autonumos],[end-game] or [teleop]
abstract class GenericScoutingStageData implements Model {}

class EndGameStage extends GenericScoutingStageData {
  EndGameClimbType type;
  EndGameStage({type}){
    this.type = type ?? EndGameClimbType.generate(EndGameClimbType.empty);
  }
  EndGameStage fromJson(Map<String,dynamic> json){
    return EndGameStage(type: json["type"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "type":type.value
    };
  }
}

class EndGameClimbType {
  static const String even = "EVEN",uneven = "UNEVEN",platform = "PLATFORM",empty = "NULL";
  String value;
  Image image;
  EndGameClimbType({this.image,this.value});
  factory EndGameClimbType.generate(String value){
    Image img;
    switch (value) {
      //TODO: add currect assests
      case even:
        img = Image.asset("");
        break;
        case uneven:
        img = Image.asset("");
        break;
        case platform:
        img = Image.asset("");
        break;
        case empty:
        img = Image.asset("");
        break;
      default:
    }
    return EndGameClimbType(value: value,image: img);
  }
}
class MidGameStage extends GenericScoutingStageData {
  List<ShootingCycle> shooting;
  List<BallsCycle> balls;
  List<RolletCycle> rollet;

  MidGameStage(
      {this.balls = const [],
      this.rollet = const [],
      this.shooting = const [],});
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
}
