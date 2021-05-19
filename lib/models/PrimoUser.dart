import 'dart:async';

import 'package:ansicolor/ansicolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:scouting_app_2/models/Team.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class PrimoUser {
  User user;
  Map<int, bool> favorites;
  PrimoUser({this.favorites, this.user});
}


