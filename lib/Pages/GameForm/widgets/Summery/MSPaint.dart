import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Utils/Vector.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';

class Painter<T extends Cycle> extends CustomPainter {
  List<T> cycles;
  num Function(T c) alpha;
  Painter({this.cycles,this.alpha});
  @override
  void paint(Canvas canvas, Size size) {
    var myPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    cycles.forEach((e) {
      Vector2d pos = e.position * Vector2d(size.width, size.height);
      myPaint = myPaint..color = Colors.red.withAlpha(alpha(e));
      canvas.drawCircle(Offset(pos.x, pos.y), 5, myPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
