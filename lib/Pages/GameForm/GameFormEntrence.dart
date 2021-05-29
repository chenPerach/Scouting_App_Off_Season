import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/nav_drawer.dart';

class GameForm extends StatelessWidget {
  static const String route = "/game_form";

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      drawer: NavDrawer(),
      body: Center(
          child: Container(
        child: ElevatedButton(
            onPressed: () =>
                Navigator.of(c).push(MaterialPageRoute(builder: (_) => null)),
            child: Text("Start Scouting")),
      )),
    );
  }
}
