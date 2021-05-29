import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/login.dart';
import 'package:scouting_app_2/Pages/Login/widgets/register.dart';
import 'package:scouting_app_2/Pages/WaitingPage/Waiting.dart';
import 'package:scouting_app_2/Utils/BlocCreator.dart';

// class ChangePage extends StatelessWidget {
//   ChangePage({
//     Key key,
//     @required this.controller,
//   }) : super(key: key);

//   final PageController controller;

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthenticationBloc, AuthenticationState>(
//       bloc: context.read<AuthenticationBloc>(),
//       listener: (context, state) {
//         if (state is Authenticated) {
//           print("User Succesfuly Authenticated");
//         }
//       },
//       child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//         bloc: context.read<AuthenticationBloc>(),
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             return Waiting();
//           }
//           if (state is AuthError) {
//             var e = state.exception;
//             return PageView(
//               scrollDirection: Axis.horizontal,
//               controller: controller,
//               children: <Widget>[
//                 Login(exception: e.happendOn == "LOGIN" ? e : null),
//                 Register(exception: e.happendOn == "REGISTER" ? e : null),
//               ],
//             );
//           }
//           if (state is AuthenticationInitial || state is Authenticated) {
//             return PageView(
//               scrollDirection: Axis.horizontal,
//               controller: controller,
//               children: <Widget>[
//                 Login(),
//                 Register(),
//               ],
//             );
//           }

//           return Waiting();
//         },
//       ),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageBlocCreator<AuthenticationEvent, AuthenticationState,
          AuthenticationBloc>(
        create: (_) => AuthenticationBloc(),
        builder: _build,
        listener: _listener,
      ),
    );
  }

  Widget _build(BuildContext context, AuthenticationState state) {
    if (state is AuthLoading) {
      return Waiting();
    }
    if (state is AuthError) {
      var e = state.exception;
      // controller.jumpToPage(e.happendOn == 'LOGIN'?0:1);
      return PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: <Widget>[
          Login(exception: e.happendOn == "LOGIN" ? e : null),
          Register(exception: e.happendOn == "REGISTER" ? e : null),
        ],
      );
    }
    if (state is AuthenticationInitial || state is Authenticated) {
      return PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: <Widget>[
          Login(),
          Register(),
        ],
      );
    }

    return Waiting();
  }

  void _listener(BuildContext context, AuthenticationState state) {
    if (state is Authenticated) {
      print("User Succesfuly Authenticated");
    }
  }
}
