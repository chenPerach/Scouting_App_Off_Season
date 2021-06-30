import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummeryRow extends StatelessWidget {
  final Widget title, item;
  SummeryRow({this.item, this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Container(
              child: Padding(
                child: title,
                padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
              ),
              color: Colors.black12,
            ),
            flex: 2,
            fit: FlexFit.tight,
          ),
          Flexible(child: Padding(child: item,padding: EdgeInsets.fromLTRB(10, 5, 0, 5),), flex: 3, fit: FlexFit.tight),
        ],
      ),
    );
  }
}

class SummeryRowDouble extends StatelessWidget {
  final Widget title, first, second;
  SummeryRowDouble({this.first, this.title, this.second});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Flexible(
              child: Container(
                child: title,
                color: Colors.black12,
              ),
              flex: 4),
          Flexible(child: first, flex: 3),
          Flexible(child: second, flex: 3),
        ],
      ),
    );
  }
}
