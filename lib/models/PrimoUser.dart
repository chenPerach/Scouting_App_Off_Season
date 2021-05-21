import 'package:firebase_auth/firebase_auth.dart';

class PrimoUser {
  User user;
  Map<int, bool> favorites;
  PrimoUser({this.favorites, this.user});

  bool isFavorite(int team){
    return this.favorites[team];
  }
}