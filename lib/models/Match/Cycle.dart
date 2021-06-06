
import 'package:scouting_app_2/Utils/Vector.dart';

class Cycle{
  Vector2d shootingPosition;
  num ballsOuter;
  num ballsShot;
  num ballsInner;
  num ballsLower;
  Cycle({this.ballsInner =0,this.ballsLower=0,this.ballsOuter=0,this.ballsShot=0,this.shootingPosition=const Vector2d(0,0)});
}