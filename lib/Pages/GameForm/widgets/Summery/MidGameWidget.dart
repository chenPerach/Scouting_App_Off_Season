import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';


class MidStageWidget extends StatelessWidget {
  final String title;
  final MidGameDataSummery data;
  MidStageWidget({this.title, this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Text("$title:"),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              height: 1,
              width: MediaQuery.of(context).size.width * 0.9,
            )
          ],
        ),
        SizedBox(
          height: 1,
        ),
        ShootingCycleWidget(data.shooting),
        BallsCycleWidget(data.balls),
        RolletCycleWidget(data.rollet)
      ],
    );
  }
}

class RolletCycleWidget extends StatelessWidget {
  final RolletCyclesSummery summery;
  RolletCycleWidget(this.summery);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Rollet:"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        SummeryRow(
            title: Text("Rotation:"), item: Text("${summery.rotationNumber}")),
        SummeryRow(
            title: Text("Position:"), item: Text("${summery.positionNumber}")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        SummeryRow(
          title: Text("Avg picked:"),
          item: Text("${summery.avgPicked}"),
        ),
        SummeryRow(
          title: Text("avg tranch passes:"),
          item: Text("${summery.tranchPasses / summery.balls.length}"),
        ),
        ElevatedButton(onPressed: () {}, child: Text("Heat Map")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
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
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}
