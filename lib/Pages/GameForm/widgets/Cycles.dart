import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/CollectedBalls.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Rollet.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/ShootBalls.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';
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
            onPressed: () async {
              var c = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => ShotBalls()));
              if (type.toUpperCase() == "AUTO")
                match.data.autonomus.shooting.add(c);
              else if (type.toUpperCase() == "TELEOP") 
                match.data.teleop.shooting.add(c);
              
            },
            child: Text("shot balls"),
          ),
          ElevatedButton(
            onPressed: () async {
              var c = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => CollectedBalls()));
              if (type.toUpperCase() == "AUTO")
                match.data.autonomus.balls.add(c);
              else if (type.toUpperCase() == "TELEOP") 
                match.data.teleop.balls.add(c);
            },
            child: Text("collect balls"),
          ),
          ElevatedButton(
            onPressed: () async {
              var c = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => RolletCyclePage()));
              if (type.toUpperCase() == "AUTO")
                match.data.autonomus.rollet.add(c);
              else if (type.toUpperCase() == "TELEOP") 
                match.data.teleop.rollet.add(c);
            },
            child: Text("rollet"),
          )
        ],
      ),
    );
  }
}
