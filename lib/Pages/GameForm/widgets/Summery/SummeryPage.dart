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
        children: [
          MidGameStageWidget(summery.matchData.teleop),
          MidGameStageWidget(summery.matchData.teleop),
        ],
      ),
    );
  }
}
