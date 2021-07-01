import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget { 
  final CustomPainter painter;
  HeatMap({this.painter});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("heat map"),),
      body: Center(
        child: CustomPaint(
          painter: painter,
          child: Image.asset(
            "assets/images/PlayingField/full_playing_field.jpg"
          )
        ),
      ),
    );
  }
}