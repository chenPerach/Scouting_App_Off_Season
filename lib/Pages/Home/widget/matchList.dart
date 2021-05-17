import 'package:flutter/material.dart';

class matchList extends StatefulWidget {
  List<Map> matches;
  matchList(this.matches);
  @override
  State<StatefulWidget> createState() => _matchListState(matches);
}

class _MatchListState extends State<MatchList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index))
  }
}
