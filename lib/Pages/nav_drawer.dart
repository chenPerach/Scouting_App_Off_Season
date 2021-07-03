import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/Pages/GameForm/GameFormEntrence.dart';
import 'package:scouting_app_2/Pages/SingleTeam/SingleTeam.dart';
import 'package:scouting_app_2/Pages/SingleTeam/Sorted.dart';
import 'package:scouting_app_2/main.dart';
import 'package:scouting_app_2/services/PrimoUserService.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var uc = Provider.of<UserContainer>(context);
    return Drawer(
      child: Container(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(uc.user.user.displayName ?? "Loading..."),
              accountEmail: Text(uc.user.user.email),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: uc.user.user.photoURL == null
                      ? Image.asset(
                          "assets/images/default-profile-picture.png",
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          uc.user.user.photoURL,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.house),
              title: Text("Home"),
              onTap: () =>
                  Navigator.of(context).pushNamed(FirebaseInitilaize.route),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text("Game Form"),
              onTap: () => Navigator.of(context).pushNamed(GameForm.route),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign out"),
              onTap: () {
                PrimoUserService.signOut();
                Navigator.of(context).pushNamed(FirebaseInitilaize.route);
              },
            ),

            uc.user.isAdmin ?  ListTile(
              leading: Icon(Icons.logout),
              title: Text("Single Team View"),
              onTap: () {
                Navigator.of(context).pushNamed(SingleTeamAdminPage.route);
              },
            ):Container(),
            uc.user.isAdmin ?  ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sorted"),
              onTap: () {
                Navigator.of(context).pushNamed(SortedPage.route);
              },
            ):Container(),
            Expanded(child: Container()),
            ListTile(
              trailing: Text(kVERSION),
            ),
          ],
        ),
      ),
    );
  }
}
