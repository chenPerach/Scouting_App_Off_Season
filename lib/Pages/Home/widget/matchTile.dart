import 'package:flutter/material.dart';

class _CustomText extends Text {
  const _CustomText({this.SText, this.isFavourite}) : super('');
  final String SText; //team from database
  final bool isFavourite;
  Widgetbuile(BuildContext context) {
    if (!isFavourite) {
      return Text(SText, style: TextStyle(color: Colors.blue, fontSize: 15));
    }
    return Text(SText,
        style: TextStyle(
            color: Colors.blue, fontSize: 15, backgroundColor: Colors.red));
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
                  _CustomText(SText: "team1", isFavourite: false),
                  _CustomText(SText: "team2", isFavourite: false),
                  _CustomText(SText: "team3", isFavourite: false)
                ],
              ),
              Row(children: [
                _CustomText(SText: "team4", isFavourite: false),
                _CustomText(SText: "team5", isFavourite: false),
                _CustomText(SText: "team6", isFavourite: false)
              ])
            ],
          )
        ],
      ),
    );
  }
}
