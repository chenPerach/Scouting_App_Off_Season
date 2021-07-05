import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryPage.dart';
import 'package:scouting_app_2/Pages/nav_drawer.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/gameForm.dart';

class TeamCompare extends StatefulWidget {
  static const route = "team_compare";
  @override
  _TeamCompareState createState() => _TeamCompareState();
}

class _TeamCompareState extends State<TeamCompare> {
  Team team1 = TeamsConsts.teams
                    .where((element) => element.number == 2212).first, team2 =  TeamsConsts.teams
                    .where((element) => element.number == 4586).first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: DropdownSearch<Team>(
                items: TeamsConsts.teams,
                mode: Mode.BOTTOM_SHEET,
                searchBoxDecoration: InputDecoration(hintText: "first team"),
                showSearchBox: true,
                dropdownSearchDecoration:
                    InputDecoration(border: InputBorder.none),
                itemAsString: (item) => "${item.number} ${item.nickname}",
                selectedItem: TeamsConsts.teams
                    .where((element) => element.number == 2212)
                    .first,
                onChanged: (value) {
                  setState(() {
                    team1 = value;
                  });
                },
              ),
            ),
            Container(
              width: 200,
              child: DropdownSearch<Team>(
                items: TeamsConsts.teams,
                mode: Mode.BOTTOM_SHEET,
                searchBoxDecoration: InputDecoration(hintText: "second team"),
                showSearchBox: true,
                dropdownSearchDecoration:
                    InputDecoration(border: InputBorder.none),
                itemAsString: (item) => "${item.number} ${item.nickname}",
                selectedItem: TeamsConsts.teams
                    .where((element) => element.number == 4586)
                    .first,
                onChanged: (value) {
                  setState(() {
                    team2 = value;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScoutingDataService.calculateStatistics();
                if (team1.statiscs == null || team2.statiscs == null) {
                  var sb = SnackBar(
                      content: Text(
                          "team ${team2.number} has no data"));
                  ScaffoldMessenger.of(context).showSnackBar(sb);
                  sb = SnackBar(
                      content: Text(
                          "team ${team1.number} has no data"));
                  ScaffoldMessenger.of(context).showSnackBar(sb);
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) =>
                        TwoSummeryPage(team1.statiscs, team2.statiscs)));
              },
              child: Text("compare"),
            )
          ],
        ),
      ),
    );
  }
}
