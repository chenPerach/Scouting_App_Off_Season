import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/Summery/SummeryPage.dart';
import 'package:scouting_app_2/Pages/nav_drawer.dart';
import 'package:scouting_app_2/models/Match/MatchData.dart';
import 'package:scouting_app_2/models/Match/summery/ScoutingMatchSummery.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/gameFormService.dart';

class SingleTeamAdminPage extends StatefulWidget {
  static const route = "/single_team_view";
  @override
  _SingleTeamAdminPageState createState() => _SingleTeamAdminPageState();
}

class _SingleTeamAdminPageState extends State<SingleTeamAdminPage> {
  final TextEditingController controller = TextEditingController();
  Team t = TeamsConsts.teams
                    .where((element) => element.number == 4586)
                    .first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: 200,
              child: DropdownSearch<Team>(
                items: TeamsConsts.teams,
                mode: Mode.BOTTOM_SHEET,
                searchBoxDecoration: InputDecoration(hintText: "search team"),
                showSearchBox: true,
                dropdownSearchDecoration: InputDecoration(border: InputBorder.none),
                itemAsString: (item) => "${item.number} ${item.nickname}",
                searchBoxController: controller,
                selectedItem: TeamsConsts.teams
                    .where((element) => element.number == 4586)
                    .first,
                onChanged: (value) {
                  setState(() {
                    t = value;
                  });
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ScoutingDataService.calculateStatistics();
                  ScoutingMatchSummery data = t.statiscs;
                  if (data == null) {
                    final sb = SnackBar(content: Text("no info for chosen team"));
                    ScaffoldMessenger.of(context).showSnackBar(sb);
                    return;
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SummeryPage(data)));
                },
                child: Text("see statistics"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
