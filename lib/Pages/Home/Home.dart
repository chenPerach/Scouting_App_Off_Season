import 'package:flutter/material.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(FirebaseAuthService.instance.user.displayName),
            TextButton(onPressed: () => FirebaseAuthService.instance.signOut(), child: Text("sign out"))
          ],
        ),
      ),
    );
  }
}
