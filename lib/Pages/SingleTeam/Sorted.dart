import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryPage.dart';
import 'package:scouting_app_2/Pages/nav_drawer.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/gameFormService.dart';

class SortedPage extends StatefulWidget {
  static const String route = "sorted";
  @override
  _SortedPageState createState() => _SortedPageState();
}

class _SortedPageState extends State<SortedPage> {
  static const String climbS = "CLIMB", shootS = "SHOOT";
  static int n = 0;
  String state = shootS;
  @override
  Widget build(BuildContext context) {
    ScoutingDataService.calculateStatistics();
    List<Team> l = List.from(TeamsConsts.teams);
    l.sort(state == climbS ? cmpClimb : cmpShoot);
    return Scaffold(
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(flex: 2, child: Text("Sorting type:")),
                  Flexible(
                    flex: 4,
                    child: DropdownButtonFormField<String>(
                      hint: Text("sorting type"),
                      value: state,
                      items: [
                        DropdownMenuItem(
                          child: Text(climbS.toLowerCase()),
                          value: climbS,
                        ),
                        DropdownMenuItem(
                          child: Text(shootS.toLowerCase()),
                          value: shootS,
                        )
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          state = newValue;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 10,
              child: ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, i) {
                  num score;
                  if (l[i].statiscs != null)
                    score = state == climbS
                        ? l[i].statiscs.matchData.climbScore
                        : l[i].statiscs.matchData.shootingScore;
                  else 
                  score = null;
                  return Card(
                    child: ListTile(
                      title: Text("${l[i].number} ${l[i].nickname}"),
                      trailing: Text("${score?.toDouble()?.toStringAsFixed(2) ?? "no data"}"),
                      onLongPress: () {
                        var summery = l[i].statiscs;
                        if (summery == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("does not have data")));
                          return;
                        }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SummeryPage(summery),
                        ));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  int cmpClimb(Team a, Team b) {
    num s_a = a.statiscs?.matchData?.climbScore ?? 0,
        s_b = b.statiscs?.matchData?.climbScore ?? 0;
    return s_b.compareTo(s_a);
  }

  int cmpShoot(Team a, Team b) {
    num s_a = a.statiscs?.matchData?.shootingScore ?? 0,
        s_b = b.statiscs?.matchData?.shootingScore ?? 0;
    return s_b.compareTo(s_a);
  }

  void next() {
    switch (n) {
      case 0:
        state = climbS;
        break;
      case 1:
        state = shootS;
        break;
      default:
    }
    n = (n + 1) % 2;
  }
}
