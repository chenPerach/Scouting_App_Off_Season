import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Home/Home.dart';
import 'package:scouting_app_2/Pages/Login/widgets/LoginScreen.dart';
import 'package:scouting_app_2/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) 
    {
      case FirebaseInitilaize.route:
        return MaterialPageRoute(builder: (_) => FirebaseInitilaize());
      case LoginScreen.route:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Home.route:
        return MaterialPageRoute(builder: (_) => Home());
      default:
    }
  }
}