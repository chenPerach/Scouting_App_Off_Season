import 'package:flutter/cupertino.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class MidGameStageWidget extends StatelessWidget {
  final MidGameDataSummery data;
  MidGameStageWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
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
        SummeryRow(
          title: Text("accuracy:"),
          item: Text(cyclesSummery.accuracy.toStringAsFixed(2)),
        ),
        SummeryRow(
          title: Text("Avg Inner:"),
          item: Text(cyclesSummery.innerAvg.toStringAsFixed(2)),
        ),
        SummeryRow(
          title: Text("Avg Outer:"),
          item: Text(cyclesSummery.outerAvg.toStringAsFixed(2)),
        ),
        SummeryRow(
          title: Text("Avg Lower:"),
          item: Text(cyclesSummery.lowerAvg.toStringAsFixed(2)),
        ),
      ],
    );
  }
}