import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class GeneralGameInfo extends StatelessWidget {
  final GameInfoSummery gameInfo;
  final PostGameDataSummery postData;
  GeneralGameInfo({this.gameInfo, this.postData});
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
          item: Text("${0}"),
        ),
        SummeryRow(
          title: Text("Shooting Score"),
          item: Text("${0}"),
        ),
        SummeryRow(
          title: Text("Win,Draw,Lose"),
          item: Text(
              "${postData.winningStateCounter.win},${postData.winningStateCounter.draw},${postData.winningStateCounter.lose}"),
        ),
        !_isCommentSectionEmpty() ? Container(
          height: 50*postData.comments.length.toDouble(),
          child: ListView.builder(
            itemCount: postData.comments.length,
            itemBuilder: (context, i) {
              return postData.comments[i].comment !=null ? ListTile(
                title: Text(postData.comments[i].match.toString()),
                subtitle: Text(postData.comments[i].comment),
              ):Container();
            },
          ),
        ) : Container()
        // SummeryRow(
        //   title: Text("Platform"),
        //   item: Text("${summery.platformSum}"),
        // ),
        // SummeryRow(
        //   title: Text("Nothing"),
        //   item: Text("${summery.nothingSum}"),
        // ),
        // EndGameStageWidget(data),
      ],
    );
  }
  bool _isCommentSectionEmpty(){
    for(var comment in postData.comments)
      if(comment.comment != null)
        return false;
    return true;
  }
}
