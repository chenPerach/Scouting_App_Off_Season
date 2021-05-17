import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthErrorWidget extends StatelessWidget {
  final double width;
  final String message;
  AuthErrorWidget({@required this.width, @required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      color: Colors.yellow[600],
      child: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
