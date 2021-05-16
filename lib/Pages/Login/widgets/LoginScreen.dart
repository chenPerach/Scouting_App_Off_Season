import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Login/widgets/login.dart';
import 'package:scouting_app_2/Pages/Login/widgets/register.dart';

// ignore: camel_case_types
class ChangePage extends StatelessWidget {
  //const ChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Center(
          child: Login(),
        ),
        Center(
          child: Register(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangePage(),
    );
  }
}
