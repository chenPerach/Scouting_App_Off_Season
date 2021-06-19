import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Cycles.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/EndGame.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/ExamplePage.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/MatchData.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/SummaryAndComment.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';

/// this class handles the bottom [navigation menu] view

class GameFormBottomNavPage extends StatelessWidget {
  final int index;
  final ScoutingMatch match;
  GameFormBottomNavPage({@required this.index, @required this.match});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(index),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list,color: Theme.of(context).accentColor,), label: "match data"),
          BottomNavigationBarItem(icon: Icon(Icons.list,color: Theme.of(context).accentColor,), label: "Auto"),
          BottomNavigationBarItem(icon: Icon(Icons.list,color: Theme.of(context).accentColor,), label: "teleop"),
          BottomNavigationBarItem(icon: Icon(Icons.list,color: Theme.of(context).accentColor,), label: "end game"),
          BottomNavigationBarItem(icon: Icon(Icons.list,color: Theme.of(context).accentColor,), label: "post game"),
        ],
        onTap: (i) =>
            BlocProvider.of<GameFormBloc>(context).add(GameFromChangePage(i)),
        currentIndex: index,
      ),
    );
  }

  Widget _getBody(int i) {
    switch (i) {
      case 0:
        return MatchData(
          info: this.match?.info ?? null,
          pos: this.match?.data?.startingPosition,
        );
        break;
      case 1:
        return Cycles(match: this.match, type: "Auto");
        break;
      case 2:
        return Cycles(match: this.match, type: "Teleop");
        break;
      case 3:
        return EndGamePage(match.data.endGame);
        break;
      case 4:
        return CommentAndSummary(data: match.postGameData);
        break;
      default:
        return GameFormExamplePage();
    }
  }
}
