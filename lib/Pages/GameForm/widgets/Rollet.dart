import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Utils/widgets/Buttons.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';

class RolletCyclePage extends StatefulWidget {
  @override
  RolletCyclePageState createState() => RolletCyclePageState();
}

class RolletCyclePageState extends State<RolletCyclePage> {
  RolletCycle cycle = RolletCycle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PrimoSwitchButton(
                  onPressed: () =>
                      setState(() => cycle.type = RolletCycle.position),
                  child: Text("position"),
                  isActive: cycle.type == RolletCycle.position,
                ),
                PrimoSwitchButton(
                  onPressed: () =>
                      setState(() => cycle.type = RolletCycle.rotation),
                  child: Text("rotation"),
                  isActive: cycle.type == RolletCycle.rotation,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(cycle),
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
