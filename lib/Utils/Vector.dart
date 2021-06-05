class Vector2d {
  num x,y;
  Vector2d(this.x,this.y);
  Vector2d operator /(Vector2d other)=> Vector2d(this.x/other.x, this.y/other.y);
  Vector2d operator *(Vector2d other)=> Vector2d(this.x*other.x, this.y*other.y);
  @override
  String toString() {
    return "Vector2d($x,$y)";
  }
}