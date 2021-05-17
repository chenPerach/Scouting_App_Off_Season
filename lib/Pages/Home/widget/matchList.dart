import 'package:flutter/material.dart';
import 'package:scouting_app_off_season/Pages/Home/widget/matchTile.dart';

import 'matchTile.dart';

class matchList extends StatefulWidget {
  List<Map> matches;
  matchList(this.matches);
  @override
  State<StatefulWidget> createState() => _MatchListState(matches);
}

class _MatchListState extends State<matchList> {
  List<Map> matches;
  _MatchListState(this.matches);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          return MatchTile(matches[index], index);
        });
  }
}
