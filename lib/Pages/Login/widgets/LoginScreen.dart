import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/login.dart';
import 'package:scouting_app_2/Pages/Login/widgets/register.dart';

// ignore: camel_case_types
class BlocHandler extends StatelessWidget {
  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(),
      child: ChangePage(controller: controller),
    );
  }
}

class ChangePage extends StatelessWidget {
  const ChangePage({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: context.read<AuthenticationBloc>(),
      listener: (context, state) {
        if (state is Authenticated) {
          print("User Succesfuly Authenticated");
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: context.read<AuthenticationBloc>(),
        builder: (context, state) {
          if (state is AuthLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AuthError) {
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
          if (state is AuthenticationInitial) {
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
          return null;
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocHandler(),
    );
  }
}
