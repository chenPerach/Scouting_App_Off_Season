import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/bloc/gameform_bloc.dart';
import 'package:scouting_app_2/Pages/GameForm/widgets/ExamplePage.dart';

/// this class handles the bottom [navigation menu] view

class GameFormBottomNavPage extends StatelessWidget {
  final int index;

  GameFormBottomNavPage({@required this.index});
  final pages = [
    GameFormExamplePage(),
    GameFormExamplePage(),
    GameFormExamplePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "pre Match Data"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Auto"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "general"
          ),
        ],
        onTap: (i) => BlocProvider.of<GameformBloc>(context).add(GameFormMoveTo(i)),
        currentIndex: index,
      ),
    );
  }
}
