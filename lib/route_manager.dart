import 'package:flutter/material.dart';
import 'package:scouting_app_2/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      case FirebaseInitilaize.route:
        return MaterialPageRoute(builder: (_) => FirebaseInitilaize());
      default:
    }
    return null;
  }
}
