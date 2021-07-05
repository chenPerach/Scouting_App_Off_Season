import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/EndStageWidget.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/GeneralInfo.dart';
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
        appBar: AppBar(),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            GeneralGameInfo(
              gameInfo: summery.info,
              postData: summery.postGame,
              matchData: summery.matchData,
            ),
            MidStageWidget(
              title: "Autonumos",
              data: summery.matchData.auto,
              isAuto: true,
            ),
            MidStageWidget(
              title: "Teleop",
              data: summery.matchData.teleop,
            ),
            EndStageWidget(summery.matchData.endGame),
          ],
        ));
  }
}

class TwoSummeryPage extends StatelessWidget {
  final ScoutingMatchSummery first, second;
  final controller = PageController(
    initialPage: 0,
  );
  TwoSummeryPage(this.first, this.second);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            TwoGeneralGameInfo(
              first: first,
              second: second,
            ),
            TwoMidStageWidget(
              title: "Autonumos",
              first: first.matchData.auto,
              second: second.matchData.auto,
              isAuto: true,
            ),
            TwoMidStageWidget(
              title: "Teleop",
              first: first.matchData.teleop,
              second: second.matchData.teleop,
            ),
            TwoEndStageWidget(
              first: first.matchData.endGame,
              second: second.matchData.endGame,
            ),
          ],
        ));
  }
}
