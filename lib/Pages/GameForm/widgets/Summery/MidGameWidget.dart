import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/HeatMap.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/MSPaint.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryRow.dart';
import 'package:scouting_app_2/Utils/FileLoader.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';

class MidStageWidget extends StatelessWidget {
  final String title;
  final MidGameDataSummery data;
  final bool isAuto;
  MidStageWidget({this.title, this.data, this.isAuto = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Text("$title:"),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              height: 1,
              width: MediaQuery.of(context).size.width * 0.9,
            )
          ],
        ),
        SizedBox(
          height: 1,
        ),
        ShootingCycleWidget(
          cyclesSummery: data.shooting,
          isAuto: this.isAuto,
        ),
        BallsCycleWidget(data.balls),
        RolletCycleWidget(data.rollet)
      ],
    );
  }
}

class RolletCycleWidget extends StatelessWidget {
  final RolletCyclesSummery summery;
  RolletCycleWidget(this.summery);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Rollet:"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        SummeryRow(
            title: Text("Rotation:"), item: Text("${summery.rotationNumber}")),
        SummeryRow(
            title: Text("Position:"), item: Text("${summery.positionNumber}")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}

class BallsCycleWidget extends StatelessWidget {
  final BallsCyclesSummery summery;
  BallsCycleWidget(this.summery);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Balls:"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        SummeryRow(
          title: Text("Avg picked:"),
          item: Text("${summery.avgPicked.toStringAsFixed(2)}"),
        ),
        SummeryRow(
          title: Text("avg tranch passes:"),
          item: Text("${summery.avgTranchPasses.toStringAsFixed(2)}"),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                (MaterialPageRoute(
                  builder: (_) => HeatMap(
                    painter: Painter<BallsCycle>(
                        cycles: summery.balls,
                        alpha: (c) {
                          switch (c.numPicked) {
                            case 1:
                              return 40;
                              break;
                            case 2:
                              return 80;
                              break;
                            case 3:
                              return 120;
                              break;
                            case 4:
                              return 160;
                              break;
                            case 5:
                              return 200;
                              break;
                            default:
                              return 0;
                          }
                        },
                        img: FileLoader.img),
                  ),
                )),
              );
            },
            child: Text("Heat Map")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}

class ShootingCycleWidget extends StatelessWidget {
  final ShootingCyclesSummery cyclesSummery;
  final bool isAuto;
  ShootingCycleWidget({this.cyclesSummery, this.isAuto});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Shooting:"),
            ),
          ],
        ),
        SummeryRow(
          title: Text("Accuracy:"),
          item: Text("${cyclesSummery?.accuracy?.toStringAsFixed(2) ?? 0}%"),
        ),
        SummeryRow(
          title: Text("Avg Inner:"),
          item: Text(cyclesSummery?.innerAvg?.toStringAsFixed(2) ?? 0),
        ),
        SummeryRow(
          title: Text("Avg Outer:"),
          item: Text(cyclesSummery?.outerAvg?.toStringAsFixed(2) ?? 0),
        ),
        SummeryRow(
          title: Text("Avg Lower:"),
          item: Text(cyclesSummery?.lowerAvg?.toStringAsFixed(2) ?? 0),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HeatMap(
                    painter: Painter<ShootingCycle>(
                        cycles: cyclesSummery.shooting,
                        alpha: (c) {
                          // var acc = (c.ballsLower+c.ballsInner+c.ballsOuter)/c.ballsShot;
                          return (c.getScore() * 255 ~/ (15 * (isAuto ? 2 : 1)))
                              .toInt(); // what the fuck does ~/ mean?
                        },
                        img: FileLoader.img),
                  ),
                ),
              );
            },
            child: Text("Heat Map")),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}

class TwoMidStageWidget extends StatelessWidget {
  final String title;
  final MidGameDataSummery first, second;
  final bool isAuto;
  TwoMidStageWidget({this.title, this.first, this.second, this.isAuto = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              child: Text("$title:"),
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            )
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey,
              height: 1,
              width: MediaQuery.of(context).size.width * 0.9,
            )
          ],
        ),
        SizedBox(
          height: 1,
        ),
        TwoShootingCycleWidget(
          first: first.shooting,
          second: second.shooting,
          isAuto: this.isAuto,
        ),
        TwoBallsCycleWidget(first.balls, second.balls),
        TwoRolletCycleWidget(first.rollet, second.rollet)
      ],
    );
  }
}

class TwoRolletCycleWidget extends StatelessWidget {
  final RolletCyclesSummery first, second;
  TwoRolletCycleWidget(this.first, this.second);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Rollet:"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        TwoSummeryRow(
          title: Text("Rotation:"),
          item1: Text("${first.rotationNumber}"),
          item2: Text("${second.rotationNumber}"),
        ),
        TwoSummeryRow(
          title: Text("Position:"),
          item1: Text("${first.positionNumber}"),
          item2: Text("${second.positionNumber}"),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}

class TwoBallsCycleWidget extends StatelessWidget {
  final BallsCyclesSummery first, second;
  TwoBallsCycleWidget(this.first, this.second);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Balls:"),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        ),
        TwoSummeryRow(
          title: Text("Avg picked:"),
          item1: Text("${first.avgPicked.toStringAsFixed(2)}"),
          item2: Text("${second.avgPicked.toStringAsFixed(2)}"),
        ),
        TwoSummeryRow(
          title: Text("avg tranch passes:"),
          item1: Text("${first.avgTranchPasses.toStringAsFixed(2)}"),
          item2: Text("${second.avgTranchPasses.toStringAsFixed(2)}"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    (MaterialPageRoute(
                      builder: (_) => HeatMap(
                        painter: Painter<BallsCycle>(
                            cycles: first.balls,
                            alpha: (c) {
                              switch (c.numPicked) {
                                case 1:
                                  return 40;
                                  break;
                                case 2:
                                  return 80;
                                  break;
                                case 3:
                                  return 120;
                                  break;
                                case 4:
                                  return 160;
                                  break;
                                case 5:
                                  return 200;
                                  break;
                                default:
                                  return 0;
                              }
                            },
                            img: FileLoader.img),
                      ),
                    )),
                  );
                },
                child: Text("Heat Map")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    (MaterialPageRoute(
                      builder: (_) => HeatMap(
                        painter: Painter<BallsCycle>(
                            cycles: second.balls,
                            alpha: (c) {
                              switch (c.numPicked) {
                                case 1:
                                  return 40;
                                  break;
                                case 2:
                                  return 80;
                                  break;
                                case 3:
                                  return 120;
                                  break;
                                case 4:
                                  return 160;
                                  break;
                                case 5:
                                  return 200;
                                  break;
                                default:
                                  return 0;
                              }
                            },
                            img: FileLoader.img),
                      ),
                    )),
                  );
                },
                child: Text("Heat Map")),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}

class TwoShootingCycleWidget extends StatelessWidget {
  final ShootingCyclesSummery first, second;
  final bool isAuto;
  TwoShootingCycleWidget({this.first, this.second, this.isAuto});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Text("Shooting:"),
            ),
          ],
        ),
        TwoSummeryRow(
          title: Text("Accuracy:"),
          item1: Text("${first?.accuracy?.toStringAsFixed(2) ?? 0}%"),
          item2: Text("${second?.accuracy?.toStringAsFixed(2) ?? 0}%"),
        ),
        TwoSummeryRow(
          title: Text("Avg Inner:"),
          item1: Text(first?.innerAvg?.toStringAsFixed(2) ?? 0),
          item2: Text(second?.innerAvg?.toStringAsFixed(2) ?? 0),
        ),
        TwoSummeryRow(
          title: Text("Avg Outer:"),
          item1: Text(first?.outerAvg?.toStringAsFixed(2) ?? 0),
          item2: Text(second?.outerAvg?.toStringAsFixed(2) ?? 0),
        ),
        TwoSummeryRow(
          title: Text("Avg Lower:"),
          item1: Text(first?.lowerAvg?.toStringAsFixed(2) ?? 0),
          item2: Text(second?.lowerAvg?.toStringAsFixed(2) ?? 0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HeatMap(
                        painter: Painter<ShootingCycle>(
                            cycles: first.shooting,
                            alpha: (c) {
                              return (c.getScore() *
                                      255 ~/
                                      (15 * (isAuto ? 2 : 1)))
                                  .toInt(); // what the fuck does ~/ mean?
                            },
                            img: FileLoader.img),
                      ),
                    ),
                  );
                },
                child: Text("Heat Map")),
            ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HeatMap(
                    painter: Painter<ShootingCycle>(
                        cycles: second.shooting,
                        alpha: (c) {
                          return (c.getScore() * 255 ~/ (15 * (isAuto ? 2 : 1)))
                              .toInt(); // what the fuck does ~/ mean?
                        },
                        img: FileLoader.img),
                  ),
                ),
              );
            },
            child: Text("Heat Map")),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Container(
            color: Colors.grey,
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
          ),
        )
      ],
    );
  }
}
