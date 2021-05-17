import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';
import 'package:scouting_app_2/Pages/Login/widgets/ExceptionWiget.dart';
import 'package:scouting_app_2/Pages/Login/widgets/forgotPass.dart';
import 'package:scouting_app_2/services/auth_service.dart';

class Login extends StatefulWidget {
  final AuthException exception;
  Login({this.exception});
  @override
  _LoginState createState() {
    return _LoginState(exception: exception);
  }
}

class _LoginState extends State<Login> {
  final _password = TextEditingController();
  final _email = TextEditingController();
  final AuthException exception;
  _LoginState({this.exception});
  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final double width = 350;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(height: 16),
                  FormEmailField(controller: _email),
                  SizedBox(
                    height: 10,
                  ),
                  FormPasswordField(controller: _password),
                  exception == null ? Container() : SizedBox(height: 8),
                  exception == null
                      ? Container()
                      : AuthErrorWidget(width: width, message: exception.message),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            var bloc =
                                BlocProvider.of<AuthenticationBloc>(context);
                            bloc.add(AuthLogin(
                                email: _email.text, password: _password.text));
                          }
                        },
                        child: Text('log in'),
                      ),
                      TextButton(
                        child: Text("Forgot password"),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
