import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';

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
                controller: name,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'enter your first and last',
                  labelText: 'name',
                ),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'empty';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'email',
                  labelText: 'something@something.com',
                ),
                // ignore: missing_return
                validator: (mail) {
                  if (mail == null || mail.isEmpty) {
                    return 'empty';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(mail)) {
                    return 'invalid email';
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
                  icon: Icon(Icons.payments_sharp),
                  hintText: 'choose password',
                  labelText: 'password',
                ),
                validator: (pass) {
                  if (pass == null || pass.isEmpty) {
                    return 'empty';
                  }
                  if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                      .hasMatch(pass)) {
                    return 'ססמא עם לפחות מספר אחד ואות אחת ושישה תווים';
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
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              AuthRegister(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text));
                        }
                      },
                      child: Text('Submit',
                          style: TextStyle(color: Colors.orange, fontSize: 25)),
                    ),
                  ),
                ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPass()),
                        );
                      },
                      child: Center(
                        child: Text('forgot password because im tipesh',
                            style:
                                TextStyle(color: Colors.orange, fontSize: 25)),
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

  @override
  void dispose() {
    password.dispose();
    user.dispose();
    email.dispose();
    name.dispose();
    super.dispose();
  }
}
