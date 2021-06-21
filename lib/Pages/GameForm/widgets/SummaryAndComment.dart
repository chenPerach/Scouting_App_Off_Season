import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        children: [
          Container(
            width: 200,
            height: 200,
            child: Expanded(
              child: ElevatedButton(
                child: data.winningState.image,
                onPressed: () {
                  this.data.winningState = WinningStateGenerator.next();
                  BlocProvider.of<GameFormBloc>(context)
                      .add(GameFormUpdatePostGameData(this.data));
                },
              ),
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
              Navigator.of(context).pop();
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
