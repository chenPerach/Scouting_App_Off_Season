import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MatchData extends StatelessWidget {
  final Key _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Match Data",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 3,
            ),
            Container(
                width: min(400, MediaQuery.of(context).size.width * 0.8),
                height: 2,
                color: Theme.of(context).hintColor),
            SizedBox(
              height: 3,
            ),
            DropdownButtonFormField(items: [
              DropdownMenuItem(
                child: Text("Qualification Matches"),
                value: "qm",
              ),
              DropdownMenuItem(
                child: Text("Quarter finals"),
                value: "qf",
              ),
              DropdownMenuItem(
                child: Text("Semi finals"),
                value: "sf",
              ),
              DropdownMenuItem(child: Text("Finals"), value: "f"),
            ], key: _key)
          ],
        ),
      ),
    );
  }
}
