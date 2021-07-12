import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image/image.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/models/Match/CompLevel.dart';
import 'package:scouting_app_2/models/Match/GameInfo.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/models/matchModel.dart';
import 'package:scouting_app_2/services/HomeService.dart';

class MatchData extends StatefulWidget {
  GameInfo info;
  String pos;
  final String error;
  MatchData({this.info, this.pos, this.error});
  MatchModel getInfoByTime(DateTime time) {
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
  // MapEntry mt = MapEntry(
  //     "B1",
  //     HomeService.matchList
  //         .where((e) => e.compLevel == "qm")
  //         .toList()
  //         .where((e) => e.matchNumber == widget.info.matchNumber)
  //         .first
  //         .blueAllience
  //         .teamNumbers[0]);
  final Key _key = GlobalKey<FormState>();

  final List<CompLevel> _matchTypes = [
    CompLevel.simple("qm"),
    CompLevel.simple("qf"),
    CompLevel.simple("sf"),
    CompLevel.simple("f"),
  ];

  final List<String> _allianceTypes = ["red", "blue"];
  List<MapEntry<String, int>> calcl(MatchModel m) {
    List<MapEntry<String, int>> lst = [];
    int c = 1;
    m.redAllience.teamNumbers.forEach((element) {
      lst.add(MapEntry("R${c}", element));
      c++;
    });
    c = 1;
    m.blueAllience.teamNumbers.forEach((element) {
      lst.add(MapEntry("B${c}", element));
      c++;
    });
    return lst;
  }
  List< int> calc2(MatchModel m) {
    List< int> lst = [];
    m.redAllience.teamNumbers.forEach((element) {
      lst.add( element);
    });
    m.blueAllience.teamNumbers.forEach((element) {
      lst.add( element);
    });
    return lst;
  }

  @override
  Widget build(BuildContext ctx) {
    Set<int> numbers = Set();
    HomeService.matchList.forEach((e) {
      numbers.add(e.matchNumber);
    });
    List<MatchModel> matches =
        HomeService.matchList.where((e) => e.compLevel == "qm").toList();
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Match Data",
            style: Theme.of(ctx).textTheme.headline3,
          ),
          SizedBox(
            height: 3,
          ),
          Container(
              width: min(400, MediaQuery.of(ctx).size.width * 0.8),
              height: 2,
              color: Theme.of(ctx).hintColor),
          SizedBox(
            height: 3,
          ),
          // _DropDownRow(
          //   child: Text("Match Type"),
          //   dropDown: DropdownButtonFormField<CompLevel>(
          //     hint: Text("select game type"),
          //     value: widget.info.compLevel,
          //     items: List<DropdownMenuItem<CompLevel>>.generate(
          //       _matchTypes.length,
          //       (i) => DropdownMenuItem(
          //         child: Text(_matchTypes[i].detailed),
          //         value: _matchTypes[i],
          //       ),
          //     ),
          //     onChanged: (value) {
          //       widget.info.compLevel = value;
          //       BlocProvider.of<GameFormBloc>(ctx)
          //           .add(GameFormUpdateGameInfo(widget.info));
          //     },
          //   ),
          // ),
          _DropDownRow(
            child: Text("Match Number"),
            dropDown: DropdownButtonFormField<int>(
              value: widget.info.matchNumber,
              items: List<DropdownMenuItem<int>>.generate(
                matches.length,
                (i) => DropdownMenuItem(
                  child: Text((matches[i].matchNumber).toString()),
                  value: matches[i].matchNumber,
                ),
              ),
              onChanged: (value) {
                widget.info = GameInfo(
                    compLevel: CompLevel.simple("qm"),
                    matchNumber: value,
                    alliance: "blue",
                    teamNumber: matches
                        .where((e) => e.matchNumber == widget.info.matchNumber)
                        .first
                        .blueAllience
                        .teamNumbers[0]);
                BlocProvider.of<GameFormBloc>(ctx)
                    .add(GameFormUpdateGameInfo(widget.info));
              },
            ),
          ),
          // widget.info.matchNumber != null ? _DropDownRow(
          //   child: Text("Allience"),
          //   dropDown: DropdownButtonFormField<String>(
          //     hint: Text("select Alliance"),
          //     value: widget.info.alliance ?? "blue",
          //     items: List<DropdownMenuItem<String>>.generate(
          //       _allianceTypes.length,
          //       (i) => DropdownMenuItem(
          //         child: Container(
          //           width: 100,
          //           height: 15,
          //           color:
          //               _allianceTypes[i] == "red" ? Colors.red : Colors.blue,
          //         ),
          //         value: _allianceTypes[i],
          //       ),
          //     ),
          //     onChanged: (value) {
          //       int number = widget.info.matchNumber;
          //       widget.info = GameInfo(
          //         matchNumber: number,
          //         alliance: value
          //       );
          //       BlocProvider.of<GameFormBloc>(ctx)
          //           .add(GameFormUpdateGameInfo(widget.info));
          //     },
          //   ),
          // ) : Container(),
          widget.info.teamNumber != null
              ? _DropDownRow(
                  child: Text("team"),
                  dropDown: DropdownSearch<MapEntry<String, int>>(
                    items: calcl(matches
                        .where((e) => e.matchNumber == widget.info.matchNumber)
                        .first),
                    mode: Mode.BOTTOM_SHEET,
                    searchBoxDecoration:
                        InputDecoration(hintText: "search team"),
                    showSearchBox: true,
                    dropdownSearchDecoration:
                        InputDecoration(border: InputBorder.none),
                    itemAsString: (item) => "${item.key} - ${item.value}",
                    onChanged: (value) {
                      int number = widget.info.matchNumber;
                      widget.info = GameInfo(
                          matchNumber: number,
                          compLevel: CompLevel.simple("qm"),
                          alliance: value.key.startsWith("R") ? "red" : "blue",
                          teamNumber: value.value);
                      BlocProvider.of<GameFormBloc>(ctx)
                          .add(GameFormUpdateGameInfo(widget.info));
                    },
                    selectedItem: widget.info.matchNumber == null || !calc2(matches
                        .where((e) => e.matchNumber == widget.info.matchNumber)
                        .first).contains(widget.info.teamNumber)

                        ? MapEntry(
                            "B1",
                            matches
                                .where((e) =>
                                    e.matchNumber == widget.info.matchNumber)
                                .first
                                .blueAllience
                                .teamNumbers[0])
                        : calcl(matches
                        .where((e) => e.matchNumber == widget.info.matchNumber)
                        .first).where((e) => e.value == widget.info.teamNumber).first,
                  ),
                )
              : Container(),
          // _DropDownRow(
          //   child: Text("Team"),
          // dropDown: DropdownSearch<Team>(
          //   items: TeamsConsts.teams,
          //   mode:Mode.BOTTOM_SHEET,
          //   searchBoxDecoration: InputDecoration(hintText: "search team"),
          //   showSearchBox: true,
          //   dropdownSearchDecoration: InputDecoration(border: InputBorder.none),
          //   itemAsString: (item) => "${item.number} ${item.nickname}",
          //   onChanged: (value) {
          //     widget.info.teamNumber = value.number;
          //     BlocProvider.of<GameFormBloc>(ctx)
          //         .add(GameFormUpdateGameInfo(widget.info));
          //   },
          //   selectedItem: TeamsConsts.teams.where((element) => element.number == widget.info.teamNumber).first,
          // ),
          // ),

          SizedBox(height: 50),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/PlayingField/playing_field_starting_line.jpg",
                            fit: BoxFit.contain,
                          ),
                          Positioned(
                            width: MediaQuery.of(context).size.width,
                            top: 29,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _updateStartingLinePosition(
                                        context, "Left");
                                  },
                                  child: Text("Left"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              widget.pos == "Left"
                                                  ? Colors.orange
                                                  : Colors.blue)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateStartingLinePosition(
                                        context, "Middle");
                                  },
                                  child: Text("Middle"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              widget.pos == "Middle"
                                                  ? Colors.orange
                                                  : Colors.blue)),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updateStartingLinePosition(
                                        context, "Right");
                                  },
                                  child: Text("Right"),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              widget.pos == "Right"
                                                  ? Colors.orange
                                                  : Colors.blue)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      widget.error ?? "",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    width: 250,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateStartingLinePosition(BuildContext context, String pos) {
    var prov = BlocProvider.of<GameFormBloc>(context);
    widget.pos = pos;
    prov.add(GameFormUpdateStartingPosition(widget.pos));
  }
}

class _DropDownRow extends StatelessWidget {
  final Widget child, dropDown;
  _DropDownRow({this.child, this.dropDown});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        child,
        SizedBox(width: 15),
        Container(
            width: MediaQuery.of(context).size.width * 0.6, child: dropDown),
      ],
    );
  }
}
