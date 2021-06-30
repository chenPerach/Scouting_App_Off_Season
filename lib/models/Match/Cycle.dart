import 'package:scouting_app_2/Utils/Vector.dart';
import 'package:scouting_app_2/models/model.dart';

class ShootingCycle implements Model {
  Vector2d shootingPosition;
  num ballsOuter;
  num ballsShot;
  num ballsInner;
  num ballsLower;
  ShootingCycle(
      {this.ballsInner = 0,
      this.ballsLower = 0,
      this.ballsOuter = 0,
      this.ballsShot = 0,
      this.shootingPosition = const Vector2d(0, 0)});
  Map<String, dynamic> toJson() {
    return {
      "outer": ballsOuter.toInt(),
      "inner": ballsInner.toInt(),
      "lower": ballsLower.toInt(),
      "balls_shot": ballsShot.toInt(),
      "position": {"x": shootingPosition.x.toDouble(), "y": shootingPosition.y.toDouble()}
    };
  }

  factory ShootingCycle.fromJson(Map<String, dynamic> json) {
    return ShootingCycle(
        ballsInner: json["inner"],
        ballsLower: json["lower"],
        ballsOuter: json["outer"],
        ballsShot: json["balls_shot"],
        shootingPosition:
            Vector2d(json["position"]["x"], json["position"]["y"]));
  }
}

class BallsCycle implements Model {
  Vector2d position;
  num numPicked;
  bool tranch;
  BallsCycle({this.position = Vector2d.zero, this.numPicked = 0, this.tranch = false});

  factory BallsCycle.fromJson(Map<String, dynamic> json) {
    return BallsCycle(
        position: Vector2d(json["position"]["x"], json["position"]["y"]),
        tranch: json["tranch"],
        numPicked: json["balls_picked"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "tranch": tranch,
      "balls_picked": numPicked,
      "position": {"x": position.x.toDouble(), "y": position.y.toDouble()}
    };
  }
}

class RolletCycle implements Model {
  
  String type;
  static const String position = "POSITION", rotation = "ROTATION";
  RolletCycle({this.type = position});

  factory RolletCycle.fromJson(Map<String, dynamic> json) {
    return RolletCycle(type: json["type"]);
  }

  Map<String, dynamic> toJson() {
    return {"type": type};
  }
}
