import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class Home extends StatelessWidget {
  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    UserContainer uc = Provider.of<UserContainer>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(uc.user?.user?.displayName ?? "Loading..."),
            TextButton(onPressed: () => FirebaseAuthService.instance.signOut(), child: Text("sign out")),
          ],
        ),
      ),
    );
  }
}
