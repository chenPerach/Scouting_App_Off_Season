import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/PositionPage.dart';
import 'package:scouting_app_2/Utils/Vector.dart';
import 'package:scouting_app_2/Utils/widgets/Buttons.dart';
import 'package:scouting_app_2/Utils/widgets/PrimoSlider.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';

class ShotBalls extends StatefulWidget {
  @override
  _ShotBallsState createState() => _ShotBallsState();
}

class _ShotBallsState extends State<ShotBalls> {
  ShootingCycle c = ShootingCycle();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimoSlider(
              title: "Balls Shot",
              getValue: () => c.ballsShot.toDouble(),
              onChange: (value) {
                if (value >= c.ballsInner + c.ballsLower + c.ballsLower)
                  setState(() => c.ballsShot = value);
              },
            ),
            PrimoSlider(
              // img: "assets/images/GamePieces/Inner.png",
              title: "Inner",
              getValue: () => c.ballsInner.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= value + c.ballsLower + c.ballsOuter)
                  setState(() => c.ballsInner = value);
              },
            ),
            PrimoSlider(
              img: "assets/images/GamePieces/Outer.png",
              // title: "Outer",
              getValue: () => c.ballsOuter.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= c.ballsInner + c.ballsLower + value)
                  setState(() => c.ballsOuter = value);
              },
            ),
            PrimoSlider(
              img: "assets/images/GamePieces/Lower.png",
              // title: "Lower",
              getValue: () => c.ballsLower.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= c.ballsInner + value + c.ballsOuter)
                  setState(() => c.ballsLower = value);
              },
            ),
            PrimoSwitchButton(
              onPressed:() async {
                var pos = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PositionPage()));
                setState(() {
                  this.c.position = pos;
                });
              } ,
              child: Text("Shot Position"),
              isActive: c.position == Vector2d.zero,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (c.ballsShot == 0 || c.position == Vector2d.zero)
                    return;
                  Navigator.of(context).pop(c);
                },
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}