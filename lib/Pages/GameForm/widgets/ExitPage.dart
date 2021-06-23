import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 10),()=>
    Navigator.of(context).pop());
    return Scaffold();
  }
}