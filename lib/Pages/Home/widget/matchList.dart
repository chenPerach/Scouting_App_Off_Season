import 'package:flutter/material.dart';

import 'matchTile.dart';

class MatchList extends StatefulWidget {
  final List<Map> matches;
  MatchList(this.matches);
  @override
  State<StatefulWidget> createState() => _MatchListState(matches);
}

class _MatchListState extends State<MatchList> {
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
