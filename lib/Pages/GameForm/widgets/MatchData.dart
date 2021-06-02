import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';

class MatchData extends StatefulWidget {
  ScoutingMatch match;

  MatchData(ScoutingMatch match) {
    if (match == null) {
      var closestMatch = getMatchByTime(DateTime.now());
      this.match = ScoutingMatch(
          compLevel: CompLevel.simple(closestMatch.compLevel),
          matchNumber: closestMatch.matchNumber,
          teamNumber: closestMatch.blueAllience.teamNumbers[0],
          alliance: "blue");
    }
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

  @override
  _MatchDataState createState() => _MatchDataState();
}

class _MatchDataState extends State<MatchData> {
  final int pageNumber = 0;

  final Key _key = GlobalKey<FormState>();

  final List<CompLevel> _matchTypes = [
    CompLevel.simple("qm"),
    CompLevel.simple("qf"),
    CompLevel.simple("sf"),
    CompLevel.simple("f"),
  ];

  final List<String> _allianceTypes = ["red", "blue"];

  @override
  Widget build(BuildContext context) {
    var model = HomeService.matchList
        .where((e) =>
            e.matchNumber == widget.match.matchNumber &&
            e.compLevel == widget.match.compLevel.compLevel)
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
                value: widget.match.compLevel,
                items: List<DropdownMenuItem<CompLevel>>.generate(
                  _matchTypes.length,
                  (i) => DropdownMenuItem(
                    child: Text(_matchTypes[i].compLevelDetailed),
                    value: _matchTypes[i],
                  ),
                ),
                onChanged: (value) {
                  var m = widget.match.clone();
                  m.compLevel = value;
                  BlocProvider.of<GameformBloc>(context)
                      .add(GameFormUpdate(pageNumber, m));
                },
              ),
            ),
            _DropDownRow(
              child: Text("Match Number"),
              dropDown: DropdownButtonFormField<int>(
                hint: Text("select game type"),
                value: widget.match.matchNumber,
                items: List<DropdownMenuItem<int>>.generate(
                  HomeService.matchList
                      .where((e) => e.compLevel == "qm")
                      .length,
                  (i) => DropdownMenuItem(
                    child: Text((i + 1).toString()),
                    value: i + 1,
                  ),
                ),
                onChanged: (value) {
                  var m = widget.match.clone();
                  m.matchNumber = value;
                  BlocProvider.of<GameformBloc>(context)
                      .add(GameFormUpdate(pageNumber, m));
                },
              ),
            ),
            _DropDownRow(
              child: Text("Allience"),
              dropDown: DropdownButtonFormField<String>(
                hint: Text("select Alliance"),
                value: widget.match.alliance,
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
                  var m = widget.match.clone();
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
                value: widget.match.teamNumber,
                items: List<DropdownMenuItem<int>>.generate(
                  TeamsConsts.teams.length,
                  (i) => DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Text(TeamsConsts.teams[i].number.toString()),
                          SizedBox(width: 5),
                          Text(TeamsConsts.teams[i].nickname)
                        ],
                      ),
                    ),
                    value: TeamsConsts.teams[i].number,
                  ),
                ),
                onChanged: (value) {
                  var m = widget.match.clone();
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
