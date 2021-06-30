import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class MidGameStageWidget extends StatelessWidget {
  final MidGameDataSummery data;
  MidGameStageWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShootingCycleWidget(data.shooting),
        BallsCycleWidget(data.balls),
      ],
    );
  }
}

class BallsCycleWidget extends StatelessWidget {
  final BallsCyclesSummery summery;
  BallsCycleWidget(this.summery);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Balls:"),
            ),
          ],
        ),
      ],
    );
  }
}

class ShootingCycleWidget extends StatelessWidget {
  final ShootingCyclesSummery cyclesSummery;
  ShootingCycleWidget(this.cyclesSummery);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Shooting:"),
            ),
          ],
        ),
        SummeryRow(
          title: Text("Accuracy:"),
          item: Text("${cyclesSummery?.accuracy?.toStringAsFixed(2) ?? 0}%"),
        ),
        SummeryRow(
          title: Text("Avg Inner:"),
          item: Text(cyclesSummery?.innerAvg?.toStringAsFixed(2) ?? 0),
        ),
        SummeryRow(
          title: Text("Avg Outer:"),
          item: Text(cyclesSummery?.outerAvg?.toStringAsFixed(2) ?? 0),
        ),
        SummeryRow(
          title: Text("Avg Lower:"),
          item: Text(cyclesSummery?.lowerAvg?.toStringAsFixed(2) ?? 0),
        ),
        ElevatedButton(onPressed: () {}, child: Text("Heat Map")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
        )
      ],
    );
  }
}