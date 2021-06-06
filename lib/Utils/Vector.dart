import 'package:equatable/equatable.dart';

class Vector2d extends Equatable{
  final num x,y;
  static const Vector2d zero = Vector2d(0,0);

  const Vector2d(this.x,this.y);
  Vector2d operator /(Vector2d other)=> Vector2d(this.x/other.x, this.y/other.y);
  Vector2d operator *(Vector2d other)=> Vector2d(this.x*other.x, this.y*other.y);
  @override
  String toString() {
    return "Vector2d($x,$y)";
  }
  @override
  List<Object> get props => [x,y];
}