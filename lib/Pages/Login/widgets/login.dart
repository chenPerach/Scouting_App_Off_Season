import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  final password = TextEditingController();
  final email = TextEditingController();


  @override
  void dispose() {
    password.dispose();
    email.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Image(
                image: NetworkImage(
                    'https://i.pinimg.com/originals/79/3d/c9/793dc92fc5b0e5fc85c9a1e31efa0749.jpg'),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: 'email',
                    labelText: 'enter your email',
                    icon: Icon(Icons.person),
                  ),
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'password',
                    labelText: 'password',
                    icon: Icon(Icons.alarm),
                  ),
                  validator: (pass) {
                    if (pass == null || pass.isEmpty) {
                      return 'empty';
                    }
                    return null;
                  },
                ),
              ),
              Center(
                child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: FlatButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            var bloc = BlocProvider.of<AuthenticationBloc>(context);
                            bloc.add(AuthLogin(email: email.text , password: password.text));
                          }
                        },
                        child: Text(
                          'log in',
                          style: TextStyle(color: Colors.orange, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
