import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/ShootBalls.dart';
import 'package:scouting_app_2/models/Match/ScoutingMatch.dart';

class Cycles extends StatelessWidget {
  final String type;
  final ScoutingMatch match;
  const Cycles({this.type, this.match});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$type Stage",
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
        ElevatedButton(
          onPressed: () async{
            var c = await Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ShotBalls()));
            //TODO: implement the gotten Cycle
          },
          child: Text("shot balls"),
        ),
      ],
    ));
  }
}
