import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Utils/widgets/Buttons.dart';
import 'package:scouting_app_2/models/Match/Cycle.dart';

class RolletCyclePage extends StatefulWidget {
  @override
  RolletCyclePageState createState() => RolletCyclePageState();
}

class RolletCyclePageState extends State<RolletCyclePage> {
  RolletType cycleType = RolletGenerator.next();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()=>
              setState(() =>
                cycleType = RolletGenerator.next())
            , child: cycleType.img),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(cycleType.cycle),
              child: Text("submit"),
            )
          ],
        ),
      ),
    );
  }
}
