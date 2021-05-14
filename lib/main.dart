import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_off_season/Pages/Home/Home.dart';
import 'package:scouting_app_off_season/Pages/Login/widgets/Login.dart';
import 'package:scouting_app_off_season/services/firebase_auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _isInitilazed = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _isInitilazed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return HandleAuth();
          else
            return _WaitingApp();
        },
      ),
    );
  }
}

class HandleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthService.instance.authState(),
      builder: (context, snapshot) {
        return snapshot.data == null ? Login() : Home();
      },
    );
  }
}

class _WaitingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
