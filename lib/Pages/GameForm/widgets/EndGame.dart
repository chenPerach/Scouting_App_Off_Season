import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';

class EndGamePage extends StatelessWidget {
  final EndGameStage data;
  EndGamePage(this.data);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "End Game",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 300,
            height: 3,
            color: Colors.grey,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 200,
            height: 200,
            child: ElevatedButton(
              onPressed: () => BlocProvider.of<GameFormBloc>(context)
                  .add(GameFormUpdateEndGame(data)),
              child: data.type.image,
            ),
          )
        ],
      ),
    );
  }
}
