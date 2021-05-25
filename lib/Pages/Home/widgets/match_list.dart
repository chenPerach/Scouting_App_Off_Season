import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Home/widgets/match_tile.dart';
import 'package:scouting_app_2/models/matchModel.dart';

class MatchList extends StatelessWidget {
  final List<MatchModel> matches;
  MatchList({this.matches});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.matches.length,
      itemBuilder: (context, index) => MatchTile(this.matches[index]),
    );
  }
}
