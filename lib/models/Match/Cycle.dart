import 'package:scouting_app_2/Utils/Vector.dart';
import 'package:scouting_app_2/models/model.dart';

class Cycle {
  Vector2d position;
  Cycle(this.position);
}

class ShootingCycle extends Cycle implements Model {
  num ballsOuter;
  num ballsShot;
  num ballsInner;
  num ballsLower;
  ShootingCycle(
      {this.ballsInner = 0,
      this.ballsLower = 0,
      this.ballsOuter = 0,
      this.ballsShot = 0,
      position = Vector2d.zero})
      : super(position);
  Map<String, dynamic> toJson() {
    return {
      "outer": ballsOuter.toInt(),
      "inner": ballsInner.toInt(),
      "lower": ballsLower.toInt(),
      "balls_shot": ballsShot.toInt(),
      "position": {"x": position.x.toDouble(), "y": position.y.toDouble()}
    };
  }

  factory ShootingCycle.fromJson(Map<String, dynamic> json) {
    return ShootingCycle(
        ballsInner: json["inner"],
        ballsLower: json["lower"],
        ballsOuter: json["outer"],
        ballsShot: json["balls_shot"],
        position: Vector2d(json["position"]["x"], json["position"]["y"]));
  }

  num getScore() {
    return ballsInner * 3 + ballsLower + ballsOuter * 2;
  }
}

class BallsCycle extends Cycle implements Model {
  num numPicked;
  bool tranch;
  BallsCycle({this.numPicked = 0, this.tranch = false, position})
      : super(position);

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
