import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';
import 'package:scouting_app_2/Pages/Login/widgets/ExceptionWiget.dart';
import 'package:scouting_app_2/services/auth_service.dart';


class Register extends StatefulWidget {
  AuthException exception;
  Register({this.exception});
  @override
  _RegisterState createState() {
    return _RegisterState(exception: exception);
  }
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final user = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final AuthException exception;
  final double width = 350;
  _RegisterState({this.exception});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: this.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 10),
                FormEmailField(controller: email),
                SizedBox(height: 8),
                FormPasswordField(controller: password),
                SizedBox(height: 8),
                FormNameField(controller: name),
                exception == null ? Container() : SizedBox(height: 8),
                  exception == null
                      ? Container()
                      : AuthErrorWidget(width: width, message: exception.message),
                ElevatedButton(
                  child: Text("Register"),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState.validate()) {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthRegister(
                              name: name.text,
                              email: email.text,
                              password: password.text));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    password.dispose();
    user.dispose();
    email.dispose();
    name.dispose();
    super.dispose();
  }
}
