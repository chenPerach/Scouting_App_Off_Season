import 'package:flutter/material.dart';

class PrimoSwitchButton extends StatelessWidget {
  final bool isActive;
  final Color activeColor = Colors.orange, unactiveColor = Colors.blue;
  void Function() onPressed;
  final Widget child;
  PrimoSwitchButton({this.isActive,this.onPressed,this.child});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      child: child,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              this.isActive ? activeColor : unactiveColor)),
    );
  }
}
