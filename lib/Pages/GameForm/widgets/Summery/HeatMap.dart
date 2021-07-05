import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget {
  final CustomPainter painter;
  final Image img =
      Image.asset("assets/images/PlayingField/playing_field_minimaized.jpg");
  HeatMap({this.painter});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("heat map"),
      ),
      body: Center(
        child: Stack(
          children: [
            //TODO: does not display the data properly, needs to be fixed.
            Image.asset(
              "assets/images/PlayingField/playing_field_minimaized.jpg",
              width: MediaQuery.of(context).size.height *0.51762,
              height: MediaQuery.of(context).size.height,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height *0.51762,
              height: MediaQuery.of(context).size.height,
              child: CustomPaint(
                painter: painter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
