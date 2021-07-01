import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/PostGameData.dart';

class CommentAndSummary extends StatelessWidget {
  final PostGameData data;
  CommentAndSummary({this.data});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "winning state:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 200,
              child: ElevatedButton(
                child: data.winningState.image,
                onPressed: () {
                  this.data.winningState = WinningStateGenerator.next();
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.data));
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "playing type:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
              height: 200,
              child: ElevatedButton(
                child: Text(data.playingType.type),
                onPressed: () {
                  this.data.playingType = PlayingTypeGenerator.next();
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.data));
                },
              ),
            ),
            Container(
              width: 250,
              child: TextField(
                decoration: InputDecoration(hintText: "comment"),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  data.comment = value;
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.data));
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var user =
                    Provider.of<UserContainer>(context, listen: false).user;
                BlocProvider.of<GameFormBloc>(context)
                    .add(GameFormUploadMatch(user: user));
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
