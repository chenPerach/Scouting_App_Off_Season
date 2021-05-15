import 'package:flutter/material.dart';
import 'package:scouting_app_2/Pages/Login/widgets/register.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'name',
                labelText: 'user name',
              ),
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'password',
                labelText: 'password',
              ),
              validator: (pass) {
                if (pass == null || pass.isEmpty) {
                  return 'empty';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
