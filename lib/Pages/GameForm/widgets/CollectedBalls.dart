import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/PositionPage.dart';
import 'package:scouting_app_2/Utils/Vector.dart';
import 'package:scouting_app_2/Utils/widgets/Buttons.dart';
import 'package:scouting_app_2/Utils/widgets/PrimoSlider.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';

class CollectedBalls extends StatefulWidget {
  @override
  _CollectedBallsState createState() => _CollectedBallsState();
}

class _CollectedBallsState extends State<CollectedBalls> {
  BallsCycle cycle = BallsCycle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              "collected balls",
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              width: 300,
              height: 5,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            PrimoSlider(
              title: "picked num",
              getValue: () => cycle.numPicked.toDouble(),
              onChange: (value) => setState(() => cycle.numPicked = value),
            ),
            PrimoSwitchButton(
              child: Text("passed through tranch?"),
              onPressed: () => setState(() => cycle.tranch = !cycle.tranch),
              isActive: cycle.tranch,
            ),
            PrimoSwitchButton(
              onPressed: () async {
                var pos = await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => PositionPage()));
                setState(() {
                  cycle.position = pos;
                });
              },
              child: Text("Collect Position"),
              isActive: cycle.position == Vector2d.zero,
            ),
            ElevatedButton(
              onPressed: () {
                if (cycle.numPicked > 0)
                  Navigator.of(context).pop(cycle);
              },
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
