import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.

  final pass = TextEditingController();
  final user = TextEditingController();

  @override
  void dispose() {
    pass.dispose();
    user.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
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
                controller: user,
                decoration: const InputDecoration(
                  hintText: 'name',
                  labelText: 'user name',
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
                controller: pass,
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
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
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
    );
  }
}
