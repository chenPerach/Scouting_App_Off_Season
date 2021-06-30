import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class EndStageWidget extends StatelessWidget {
  final EndGameSummery summery;
  EndStageWidget(this.summery);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Text("End Game:"),
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
        SummeryRow(
          title: Text("EvenClimb Sum"),
          item: Text("${summery.evenSum}"),
        ),

        SummeryRow(
          title: Text("UnevenClimb Sum"),
          item: Text("${summery.climbSum}"),
        ),
        SummeryRow(
          title: Text("Platform"),
          item: Text("${summery.platformSum}"),
        ),
        SummeryRow(
          title: Text("Nothing"),
          item: Text("${summery.nothingSum}"),
        ),
        // EndGameStageWidget(data),
      ],
    );
  }
}
