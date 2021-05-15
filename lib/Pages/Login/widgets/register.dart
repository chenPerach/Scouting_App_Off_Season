import 'package:flutter/material.dart';

import 'forgotPass.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'איך קוראים לך',
              labelText: 'שם פרטי ומשפחה',
            ),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return 'empty';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'מה המייל שלך?',
              labelText: 'מייל',
            ),
            // ignore: missing_return
            validator: (mail) {
              if (mail == null || mail.isEmpty) {
                return 'empty';
              }
              if (RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(mail)) {
                return 'מייל לא תקין';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'מה הכינוי שלך',
              labelText: 'שם משתמש',
            ),
            // ignore: non_constant_identifier_names
            validator: (User) {
              if (User == null || User.isEmpty) {
                return 'empty';
              }
              if (User.length < 4) {
                return 'בחר שם משתמש ארוך יותר';
              }
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.payments_sharp),
              hintText: 'בחר ססמא',
              labelText: 'ססמא',
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPass()),
                );
              },
              child: Text('שכחתי ססמא כי אני טיפש'),
            ),
          ),
        ],
      ),
    );
  }
}
