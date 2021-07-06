import 'package:flutter/cupertino.dart';
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

class Rollet implements Model {
  bool position, rotation;
  Rollet({this.position = false, this.rotation = false});

  factory Rollet.fromJson(Map<String, dynamic> json) {
    return Rollet(position: json["position"], rotation: json["rotation"]);
  }
  @override
  Rollet operator +(Rollet other) {
    return Rollet(
        position: this.position || other.position,
        rotation: this.rotation || other.rotation);
  }

  Map<String, dynamic> toJson() {
    return {"position": position, "rotation": rotation};
  }
}

class RolletType {
  Image img;
  Rollet cycle;
  RolletType({@required this.img, @required this.cycle});
}

class RolletGenerator {
  static int _id = 0;
  static RolletType next() {
    switch (_id) {
      case 0:
        return RolletType(
            img: Image.asset("assets/images/GamePieces/CPRC.png"),
            cycle: Rollet(rotation: true));
      case 1:
        return RolletType(
            img: Image.asset("assets/images/GamePieces/CPPC.png"),
            cycle: Rollet(position: true));
    }
    _id = (++_id)%2;
  }
}
