import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:scouting_app_2/ChangeNotifiers/UserContainer.dart';
import 'package:scouting_app_2/route_manager.dart';
import 'package:scouting_app_2/services/firebase_auth_service.dart';
import 'package:scouting_app_2/services/notification_service.dart';

import 'Pages/Home/Home.dart';
import 'Pages/Login/widgets/LoginScreen.dart';

String kVERSION = "0.2.0";
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initalize(
    onSelectNotification: (payload) async {},
  );
  ansiColorDisabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserContainer())],
      child: MaterialApp(
        builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.15), child: child),
        theme: ThemeData.dark(),
        initialRoute: FirebaseInitilaize.route,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }

  @override
  void dispose() {
    UserContainer.cancelSubscription();
    super.dispose();
  }
}

class FirebaseInitilaize extends StatelessWidget {
  static const String route = "/";
  final Future<FirebaseApp> _isInitilazed = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NotificationService.initalize(
        onSelectNotification: (payload) async{
          Navigator.of(context).pushNamed(FirebaseInitilaize.route);
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return FutureBuilder(
            future: _isInitilazed,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return StreamBuilder(
                  stream: FirebaseAuthService.instance.authState(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return LoginScreen();
                    } else {
                      return Home();
                    }
                  },
                );
              else
                return _WaitingApp();
            },
          );
        else
          return _WaitingApp();
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
