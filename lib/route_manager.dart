import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/GameForm/GameFormEntrence.dart';
import 'package:scouting_app_2/Pages/SingleTeam/SingleTeam.dart';
import 'package:scouting_app_2/Pages/SingleTeam/Sorted.dart';
import 'package:scouting_app_2/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case FirebaseInitilaize.route:
        return MaterialPageRoute(builder: (_) => FirebaseInitilaize());
      case GameForm.route:
        return MaterialPageRoute(builder: (_) => GameForm());
      case SingleTeamAdminPage.route:
        return MaterialPageRoute(builder: (_) => SingleTeamAdminPage());
      case SortedPage.route:
        return MaterialPageRoute(builder: (_) => SortedPage());
      default:
    }
    return null;
  }
}
