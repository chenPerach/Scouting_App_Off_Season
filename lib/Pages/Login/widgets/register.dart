import 'package:flutter/material.dart';

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

  final pass = TextEditingController();
  final user = TextEditingController();
  final name = TextEditingController();
  final mail = TextEditingController();

  @override
  void dispose() {
    pass.dispose();
    user.dispose();
    mail.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
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
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: mail,
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
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: name,
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
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              controller: pass,
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
          ),
          Center(
            child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
                    child: Text('Submit'),
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
                    child: Text('שכחתי ססמא כי אני טיפש'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
