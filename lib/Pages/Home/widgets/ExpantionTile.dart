import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Home/widgets/match_list.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class MatchesExpansionTile extends StatelessWidget {
  final String title;
  final List<MatchModel> matches;
  MatchesExpansionTile({this.matches,this.title});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(title),
      children: [
        Container(
            height: min(98.0 * this.matches.length,
                MediaQuery.of(context).size.height - 150),
            child: MatchList(matches: this.matches)),
      ],
    );
  }
}
