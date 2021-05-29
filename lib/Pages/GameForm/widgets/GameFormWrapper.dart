import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// this class handles the bottom [navigation menu] view

class GameFormMenu extends StatelessWidget {
  final int index;

  GameFormMenu({@required this.index});
  final pages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [],
      ),
    );
  }
}
