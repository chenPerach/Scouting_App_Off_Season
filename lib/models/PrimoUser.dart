import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PrimoUser {
  User user;
  bool isAdmin;
  Map<int, bool> favoriteTeams;
  List<int> favoriteMatches;
  PrimoUser({this.favoriteTeams,@required this.user,this.isAdmin = false,this.favoriteMatches}){
    this.favoriteMatches = this.favoriteMatches ?? [-1];
  }
  bool isFavorite(int team){
    return this.favoriteTeams[team];
  }
}
