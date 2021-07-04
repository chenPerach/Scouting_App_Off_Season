import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Utils/Vector.dart';

class PositionPage extends StatelessWidget {
  final _key = GlobalKey();
  static const num fieldWidth = 8, fieldHeight = 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: Image.asset(
            "assets/images/PlayingField/playing_field_minimaized.jpg",
            fit: BoxFit.contain,
            key: _key,
          ),
          onLongPressStart: (details) {
            var normalizedPoint =
                Vector2d(details.localPosition.dx, details.localPosition.dy) /
                    Vector2d(_key.currentContext.size.width,
                        _key.currentContext.size.height);
            var position = Vector2d(normalizedPoint.x, normalizedPoint.y) *
                Vector2d(fieldWidth, fieldHeight);
            print(position);
            Navigator.of(context).pop(Vector2d(normalizedPoint.x, normalizedPoint.y));
          },
        ),
      ),
    );
  }
}
