import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimoSlider extends StatelessWidget {
  final String title;
  final void Function(double value) onChange;
  const PrimoSlider({this.onChange, this.title, this.getValue});
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
