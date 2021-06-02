import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';

class MatchData extends StatelessWidget {
  final int pageNumber = 0;
  ScoutingMatch match;
  final Key _key = GlobalKey<FormState>();
  final List<CompLevel> _matchTypes = [
    CompLevel.simple("qm"),
    CompLevel.simple("qf"),
    CompLevel.simple("sf"),
    CompLevel.simple("f"),
  ];
  final List<String> _allianceTypes = ["red", "blue"];
  MatchData(ScoutingMatch match) {
    this.match = match;
    if (this.match == null) {
      var closestMatch = getMatchByTime(DateTime.now());
      this.match = ScoutingMatch(
          compLevel: CompLevel.simple(closestMatch.compLevel),
          matchNumber: closestMatch.matchNumber,
          teamNumber: closestMatch.blueAllience.teamNumbers[0],
          alliance: "blue");
    }
  }

  @override
  Widget build(BuildContext context) {
    var model = HomeService.matchList
        .where((e) => e.matchNumber == match.matchNumber && e.compLevel == match.compLevel.compLevel)
        .first;
    return Form(
      key: _key,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Match Data",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 3,
            ),
            Container(
                width: min(400, MediaQuery.of(context).size.width * 0.8),
                height: 2,
                color: Theme.of(context).hintColor),
            SizedBox(
              height: 3,
            ),
            _DropDownRow(
              child: Text("Match Type"),
              dropDown: DropdownButtonFormField<CompLevel>(
                hint: Text("select game type"),
                value: match.compLevel,
                items: List<DropdownMenuItem<CompLevel>>.generate(
                  _matchTypes.length,
                  (i) => DropdownMenuItem(
                    child: Text(_matchTypes[i].compLevelDetailed),
                    value: _matchTypes[i],
                  ),
                ),
                onChanged: (value) {
                  var m = match.clone();
                  m.compLevel = value;
                  BlocProvider.of<GameformBloc>(context)
                      .add(GameFormUpdate(pageNumber, m));
                },
              ),
            ),
            _DropDownRow(
              child: Text("Allience"),
              dropDown: DropdownButtonFormField<String>(
                hint: Text("select Alliance"),
                value: match.alliance,
                items: List<DropdownMenuItem<String>>.generate(
                  _allianceTypes.length,
                  (i) => DropdownMenuItem(
                    child: Container(
                      width: 100,
                      height: 15,
                      color:
                          _allianceTypes[i] == "red" ? Colors.red : Colors.blue,
                    ),
                    value: _allianceTypes[i],
                  ),
                ),
                onChanged: (value) {
                  var m = match.clone();
                  m.alliance = value;

                  BlocProvider.of<GameformBloc>(context)
                      .add(GameFormUpdate(pageNumber, m));
                },
              ),
            ),
            _DropDownRow(
              child: Text("Team"),
              dropDown: DropdownButtonFormField<int>(
                hint: Text("select Team"),
                value: match.teamNumber,
                items: List<DropdownMenuItem<int>>.generate(
                  3,
                  (i) => DropdownMenuItem(
                    child: Container(
                      child: Text(
                        (match.alliance == "red"
                                ? model.redAllience.teamNumbers[i]
                                : model.blueAllience.teamNumbers[i])
                            .toString(),
                      style: TextStyle(color: match.alliance == "red" ? Colors.red : Colors.blue),
                      ),
                    ),
                    value: match.alliance == "red"
                        ? model.redAllience.teamNumbers[i]
                        : model.blueAllience.teamNumbers[i],
                  ),
                ),
                onChanged: (value) {
                  var m = match.clone();
                  m.teamNumber = value;
                  BlocProvider.of<GameformBloc>(context)
                      .add(GameFormUpdate(pageNumber, m));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  MatchModel getMatchByTime(DateTime time) {
    MatchModel closestGame = HomeService.matchList.first;
    Duration dT = time.difference(HomeService.matchList.first.time).abs();
    for (var game in HomeService.matchList) {
      var difference = time.difference(game.time).abs();
      if (difference.compareTo(dT) <= 0) {
        closestGame = game;
        dT = difference;
      }
    }
    return closestGame;
  }
  ScoutingMatch _changeMatchNumber(ScoutingMatch match,int number){
    var m = match.clone();
    var model = HomeService.matchList
        .where((e) => e.matchNumber == match.matchNumber && e.compLevel == match.compLevel.compLevel)
        .first;
    return ScoutingMatch(
      matchNumber: number,
      alliance: match.alliance,
      teamNumber: match.alliance == "red" ? model.redAllience.teamNumbers[0] : model.blueAllience.teamNumbers[0], 
      compLevel: CompLevel.simple(model.compLevel),
    );
  }
}

class _DropDownRow extends StatelessWidget {
  final Widget child, dropDown;
  _DropDownRow({this.child, this.dropDown});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        child,
        Container(
            width: MediaQuery.of(context).size.width * 0.65, child: dropDown),
      ],
    );
  }
}
