import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class GeneralGameInfo extends StatelessWidget {
  final GameInfoSummery gameInfo;
  final PostGameDataSummery postData;
  final MatchDataSummery matchData;
  GeneralGameInfo({this.gameInfo, this.postData, this.matchData});
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
          item: Text("${this.matchData.climbScore.toStringAsFixed(2)}"),
        ),
        SummeryRow(
          title: Text("Shooting Score"),
          item: Text("${this.matchData.shootingScore.toStringAsFixed(2)}"),
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
                height: min(89 * postData.comments.length.toDouble(), 300),
                child: ListView.builder(
                  itemCount: postData.comments.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(postData.comments[i].match.toString()),
                      subtitle: Text(postData.comments[i].comment),
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

class TwoGeneralGameInfo extends StatelessWidget {
  final ScoutingMatchSummery first, second;
  TwoGeneralGameInfo({this.first, this.second});
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
        TwoSummeryRow(
          title: Text("Team"),
          item1: Text("${first.info.teamNumber}"),
          item2: Text("${second.info.teamNumber}"),
        ),
        TwoSummeryRow(
          title: Text("Climb Score"),
          item1: Text("${first.matchData.climbScore.toStringAsFixed(2)}"),
          item2: Text("${second.matchData.climbScore.toStringAsFixed(2)}"),
        ),
        TwoSummeryRow(
          title: Text("Shooting Score"),
          item1: Text("${first.matchData.shootingScore.toStringAsFixed(2)}"),
          item2: Text("${second.matchData.shootingScore.toStringAsFixed(2)}"),
        ),
        TwoSummeryRow(
          title: Text("W-L-D"),
          item1: Text(
              "${first.postGame.winningStateCounter.win},${first.postGame.winningStateCounter.lose},${first.postGame.winningStateCounter.draw}"),
          item2: Text(
              "${second.postGame.winningStateCounter.win},${second.postGame.winningStateCounter.lose},${second.postGame.winningStateCounter.draw}"),
        ),
        TwoSummeryRow(
          title: Text("Preffered Starting Side L-M-R"),
          item1: Text(
              "${first.matchData.startingSide.left},${first.matchData.startingSide.middle},${first.matchData.startingSide.right}"),
          item2: Text(
              "${second.matchData.startingSide.left},${second.matchData.startingSide.middle},${second.matchData.startingSide.right}"),
        ),
        !_isCommentSectionEmpty(first.postGame.comments) ?Card(
          child: Text("${first.info.teamNumber}'s comments"),
        ): Container(),
        !_isCommentSectionEmpty(first.postGame.comments)
            ? Container(
                height: min(
                    89 * this.first.postGame.comments.length.toDouble(), 300),
                child: ListView.builder(
                  itemCount: first.postGame.comments.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(first.postGame.comments[i].match.toString()),
                      subtitle: Text(first.postGame.comments[i].comment),
                      isThreeLine: true,
                    ),
                  ),
                ),
              )
            : Container(),
        !_isCommentSectionEmpty(second.postGame.comments) ?Card(
          child: Text("${second.info.teamNumber}'s comments"),
        ): Container(),
        !_isCommentSectionEmpty(second.postGame.comments)
            ? Container(
                height: min(
                    89 * this.second.postGame.comments.length.toDouble(), 300),
                child: ListView.builder(
                  itemCount: second.postGame.comments.length,
                  itemBuilder: (context, i) => Card(
                    child: ListTile(
                      title: Text(second.postGame.comments[i].match.toString()),
                      subtitle: Text(second.postGame.comments[i].comment),
                      isThreeLine: true,
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  bool _isCommentSectionEmpty(List<Comment> l) {
    for (var comment in l) if (comment.comment != null) return false;
    return true;
  }
}
