import 'package:flutter/material.dart';

class _CustomText extends Text {
  const _CustomText({this.SText, this.teamA}) : super('');
  final String SText; //team from database
  //final bool isFavourite;
  final bool teamA;
  Widgetbuile(BuildContext context) {
    if (!teamA) {
      return Text(SText, style: TextStyle(color: Colors.blue, fontSize: 15));
    }
    return Text(SText, style: TextStyle(color: Colors.red, fontSize: 15));
  }
}

class MatchTile extends StatelessWidget {
  final Map match;
  int matchNum = 0;
  MatchTile(this.match, this.matchNum);
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            "q" + matchNum.toString(),
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
          Column(
            //supposed to get value from database
            children: [
              Row(
                children: [
                  _CustomText(SText: "team1", teamA: true),
                  _CustomText(SText: "team2", teamA: true),
                  _CustomText(SText: "team3", teamA: true)
                ],
              ),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Row(children: [
                _CustomText(SText: "team4", teamA: false),
                _CustomText(SText: "team5", teamA: false),
                _CustomText(SText: "team6", teamA: false)
              ])
            ],
          )
        ],
      ),
    );
  }
}
