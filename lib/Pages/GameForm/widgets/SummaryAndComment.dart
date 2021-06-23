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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          Container(
            width: 250,
            child: TextField(
              decoration: InputDecoration(hintText: "comment"),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              var user = Provider.of<UserContainer>(context,listen: false).user;
              BlocProvider.of<GameFormBloc>(context)
                  .add(GameFormUploadMatch(user: user));
              },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
