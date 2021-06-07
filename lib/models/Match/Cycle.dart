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
      "outer": ballsOuter,
      "inner": ballsInner,
      "lower": ballsLower,
      "balls_shot": ballsShot,
      "position": {"x": shootingPosition.x, "y": shootingPosition.y}
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
  BallsCycle({this.position, this.numPicked, this.tranch});

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
      "position": {"x": position.x, "y": position.y}
    };
  }
}

class RolletCycle implements Model {
  String type;
  static const String position = "POSITION", rotation = "ROTATION";
  RolletCycle(this.type);

  factory RolletCycle.fromJson(Map<String, dynamic> json) {
    return RolletCycle(json["type"]);
  }

  Map<String, dynamic> toJson() {
    return {"type": type};
  }
}
