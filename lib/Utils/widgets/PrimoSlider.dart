import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimoSlider extends StatelessWidget {
  final String title;
  final void Function(double value) onChange;
  final String img;
  const PrimoSlider({this.onChange, this.title, this.getValue,this.img});
  final double Function() getValue;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        img == null ? Container(): Image.asset(img,width: 60,height: 60,),
        title == null ? Container(): Text(
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
