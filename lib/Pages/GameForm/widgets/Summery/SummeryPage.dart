import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/EndStageWidget.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/MidGameWidget.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class SummeryPage extends StatelessWidget {
  final ScoutingMatchSummery summery;
  final controller = PageController(
    initialPage: 0,
  );
  SummeryPage(this.summery);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      children: [
        MidStageWidget(
          title: "Autonumos",
          data: summery.matchData.auto,
        ),
        MidStageWidget(
          title: "Teleop",
          data: summery.matchData.auto,
        ),
        EndStageWidget(summery.matchData.endGame),
      ],
    ));
  }
}


