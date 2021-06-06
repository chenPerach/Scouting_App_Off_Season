import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShotBalls extends StatefulWidget {
  @override
  _ShotBallsState createState() => _ShotBallsState();
}

class _ShotBallsState extends State<ShotBalls> {
  double ballsShot = 0, inner = 0, outer = 0, lower = 0;
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
              getValue: () => ballsShot,
              onChange: (value) {
                if (value >= inner + lower + outer)
                  setState(() => ballsShot = value);
              },
            ),
            _MySlider(
              title: "Inner",
              getValue: () => inner,
              onChange: (value) {
                if (ballsShot >= value + lower + outer)
                  setState(() => inner = value);
              },
            ),
            _MySlider(
              title: "Outer",
              getValue: () => outer,
              onChange: (value) {
                if (ballsShot >= inner + lower + value)
                  setState(() => outer = value);
              },
            ),
            _MySlider(
              title: "Lower",
              getValue: () => lower,
              onChange: (value) {
                if (ballsShot >= inner + value + outer)
                  setState(() => lower = value);
              },
            ),
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
        Text("$title:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
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
