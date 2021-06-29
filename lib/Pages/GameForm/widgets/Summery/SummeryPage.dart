import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/MidGameWidget.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class SummeryPage extends StatelessWidget {
  final ScoutingMatchSummery summery;
  SummeryPage(this.summery);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                child: Text("Autonomus: "),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              )
            ],
          ),
          MidGameStageWidget(summery.matchData.auto),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                child: Text("Tele-Op: "),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              )
            ],
          ),
          MidGameStageWidget(summery.matchData.teleop),
        ],
      ),
    );
  }
}
