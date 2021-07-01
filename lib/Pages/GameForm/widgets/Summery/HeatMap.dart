import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget { 
  final CustomPainter painter;
  final Image img = Image.asset(
            "assets/images/PlayingField/playing_field_minimaized.jpg"
          ); 
  HeatMap({this.painter});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("heat map"),),
      body: Center(
        child: FittedBox(
          child: SizedBox(
            width: MediaQuery.of(context).size.height/2,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: painter,
            ),
          ),
        ),
      ),
    );
  }
}