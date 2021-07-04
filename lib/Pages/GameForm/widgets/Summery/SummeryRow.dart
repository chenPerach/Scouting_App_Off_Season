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
          Flexible(
            child: Padding(
              child: item,
              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
          
        ],
      ),
    );
  }
}

class TwoSummeryRow extends StatelessWidget {
  final Widget title, item1, item2;
  TwoSummeryRow({this.item1, this.item2, this.title});
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
            flex: 4,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Padding(
              child: item1,
              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
          Flexible(
            child: Padding(
              child: item2,
              padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
        ],
      ),
    );
  }
}
