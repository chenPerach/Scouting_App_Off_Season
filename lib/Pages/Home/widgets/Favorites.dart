import 'package:flutter/material.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/models/Team.dart';

class Favorites extends StatefulWidget {
  final UserContainer _user;
  Favorites(this._user);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favorites = widget._user.user.favoriteTeams;
    return Scaffold(
      appBar: AppBar(
          shadowColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(widget._user.user);
            },
          )),
      body: Center(
        child: ListView.builder(
          itemCount: TeamsConsts.teams.length,
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
                  onPressed: () {
                    setState(() {
                      var user = widget._user.user;
                      user.favoriteTeams[teamNumber] =
                          !user.favoriteTeams[teamNumber];
                      widget._user.user = user;
                    });
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
