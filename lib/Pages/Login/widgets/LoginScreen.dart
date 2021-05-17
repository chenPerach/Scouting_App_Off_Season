import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/login.dart';
import 'package:scouting_app_2/Pages/Login/widgets/register.dart';

class ChangePage extends StatelessWidget {
  ChangePage({
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
            var e = state.exception;
            return PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                Login(exception: e.happendOn == "LOGIN" ? e : null),
                Register(exception: e.happendOn == "REGISTER" ? e : null),
              ],
            );
          }
          if (state is AuthenticationInitial) {
            return PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: <Widget>[
                Login(),
                Register(),
              ],
            );
          }
          return null;
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => AuthenticationBloc(),
        child: ChangePage(controller: controller),
      ),
    );
  }
}
