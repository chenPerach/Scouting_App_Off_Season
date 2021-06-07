import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Cycles.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/ExamplePage.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/MatchData.dart';
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
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "pre Match Data"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Auto"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "general"),
        ],
        onTap: (i) => BlocProvider.of<GameformBloc>(context)
            .add(GameFormUpdate(i, this.match)),
        currentIndex: index,
      ),
    );
  }

  Widget _getBody(int i) {
    switch (i) {
      case 0:
        return MatchData(this.match);
        break;
      case 1:
        return Cycles(match: this.match, type: "Auto");
        break;
      default:
        return GameFormExamplePage();
    }
  }
}
