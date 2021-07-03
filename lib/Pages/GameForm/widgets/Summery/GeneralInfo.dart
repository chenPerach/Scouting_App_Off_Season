import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class GeneralGameInfo extends StatelessWidget {
  final GameInfoSummery gameInfo;
  final PostGameDataSummery postData;
  final MatchDataSummery matchData;
  GeneralGameInfo({this.gameInfo, this.postData,this.matchData});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Text("General Info:"),
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
              width: MediaQuery.of(context).size.width * 0.95,
            )
          ],
        ),
        SizedBox(
          height: 1,
        ),

        SummeryRow(
          title: Text("Team"),
          item: Text("${gameInfo.teamNumber}"),
        ),
        SummeryRow(
          title: Text("Climb Score"),
          item: Text("${this.matchData.climbScore}"),
        ),
        SummeryRow(
          title: Text("Shooting Score"),
          item: Text("${this.matchData.shootingScore}"),
        ),
        SummeryRow(
          title: Text("W-L-D"),
          item: Text(
              "${postData.winningStateCounter.win},${postData.winningStateCounter.lose},${postData.winningStateCounter.draw}"),
        ),
        SummeryRow(
          title: Text("Preffered Starting Side L-M-R"),
          item: Text(
              "${matchData.startingSide.left},${matchData.startingSide.middle},${matchData.startingSide.right}"),
        ),
        !_isCommentSectionEmpty()
            ? Container(
                height: min(89 * postData.comments.length.toDouble(),300),
                child: ListView.builder(
                  itemCount: postData.comments.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(postData.comments[i].match.toString()),
                      subtitle:  Text(postData.comments[i].comment),
                      isThreeLine: true,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  bool _isCommentSectionEmpty() {
    for (var comment in postData.comments)
      if (comment.comment != null) return false;
    return true;
  }
}
