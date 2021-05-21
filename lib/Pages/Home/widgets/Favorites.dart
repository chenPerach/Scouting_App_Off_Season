import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/Home/bloc/home_bloc.dart';
import 'package:scouting_app_2/models/PrimoUser.dart';
import 'package:scouting_app_2/models/Team.dart';

class Favorites extends StatelessWidget {
  BuildContext _context;
  Favorites(this._context);
  @override
  Widget build(BuildContext context) {
    var uc = Provider.of<UserContainer>(context);
    var favorites = uc.user.favorites;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
          itemCount: uc.user.favorites.length,
          itemBuilder: (context, index) {
            String teamNickName = TeamsConsts.teams[index].nickname;
            int teamNumber = TeamsConsts.teams[index].number;
            return Card(
              child: ListTile(
                title: Text(teamNickName),
                subtitle: Text(teamNumber.toString()),
                trailing: IconButton(
                  icon: favorites[teamNumber]
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border),
                      onPressed: () async {
                        var user = uc.user;
                        user.favorites[teamNumber] = !user.favorites[teamNumber];
                        PrimoUserService.addUser(user);
                        uc.user = user; 
                      },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
