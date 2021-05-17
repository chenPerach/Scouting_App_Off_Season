import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';

import 'forgotPass.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final user = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
