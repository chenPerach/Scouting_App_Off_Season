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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MidStageWidget(
              title: "Autonomus",
              data: summery.matchData.auto,
            ),
            MidStageWidget(
              title: "Teleop",
              data: summery.matchData.teleop,
            ),
          ],
        ),
      ),
    );
  }
}

class MidStageWidget extends StatelessWidget {
  final String title;
  final MidGameDataSummery data;
  MidStageWidget({this.title, this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(color: Colors.grey,height: 1,width: MediaQuery.of(context).size.width*0.9,)
          ],
        ),
        SizedBox(height: 1,),

        MidGameStageWidget(data),
      ],
    );
  }
}
