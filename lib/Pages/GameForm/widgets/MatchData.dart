import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/Match.dart';

class MatchData extends StatelessWidget {
  final int pageNumber = 0;
  final Match match;
  MatchData(this.match);
  final Key _key = GlobalKey<FormState>();
  final List<CompLevel> _matchTypes = [
    CompLevel.simple("qm"),
    CompLevel.simple("qf"),
    CompLevel.simple("sf"),
    CompLevel.simple("f"),
  ];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Match Type"),
                Container(
                  width: MediaQuery.of(context).size.width*0.65,
                  child: DropdownButtonFormField<CompLevel>(
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
                      BlocProvider.of<GameformBloc>(context).add(GameFormUpdate(pageNumber,m));
                    },
                    key: _key,
                  ),
                ),
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}
