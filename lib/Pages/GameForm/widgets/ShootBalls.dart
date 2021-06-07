import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/PositionPage.dart';
import 'package:scouting_app_2/Utils/Vector.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _MySlider(
              title: "Balls Shot",
              getValue: () => c.ballsShot.toDouble(),
              onChange: (value) {
                if (value >= c.ballsInner + c.ballsLower + c.ballsLower)
                  setState(() => c.ballsShot = value);
              },
            ),
            _MySlider(
              title: "Inner",
              getValue: () => c.ballsInner.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= value + c.ballsLower + c.ballsOuter)
                  setState(() => c.ballsInner = value);
              },
            ),
            _MySlider(
              title: "Outer",
              getValue: () => c.ballsOuter.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= c.ballsInner + c.ballsLower + value)
                  setState(() => c.ballsOuter = value);
              },
            ),
            _MySlider(
              title: "Lower",
              getValue: () => c.ballsLower.toDouble(),
              onChange: (value) {
                if (c.ballsShot >= c.ballsInner + value + c.ballsOuter)
                  setState(() => c.ballsLower = value);
              },
            ),
            ElevatedButton(
              onPressed: () async {
                var pos = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PositionPage()));
                setState(() {
                  this.c.shootingPosition = pos;
                });
              },
              child: Text("Shot Position"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      c.shootingPosition == Vector2d.zero
                          ? Colors.orange
                          : Colors.blue)),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (c.ballsShot == 0 || c.shootingPosition == Vector2d.zero)
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

class _MySlider extends StatelessWidget {
  final String title;
  final void Function(double value) onChange;
  const _MySlider({this.onChange, this.title, this.getValue});
  final double Function() getValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$title:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        SizedBox(
          width: 5,
        ),
        Slider(
          label: title,
          min: 0,
          max: 5,
          divisions: 5,
          value: getValue(),
          onChanged: onChange,
        ),
      ],
    );
  }
}
