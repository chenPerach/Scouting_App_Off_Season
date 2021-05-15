import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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

  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<LoginState>.
  final TextEditingController _email = TextEditingController(),
      _password = TextEditingController();
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
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration(
                hintText: 'email',
                labelText: 'enter your email',
              ),
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'please enter your password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _password,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'password',
                labelText: 'enter your password',
              ),
              validator: (pass) {
                if (pass == null || pass.isEmpty) {
                  return "please enter password";
                }
                RegExp reg = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
                if (reg.hasMatch(pass)) {
                  return "invalid password";
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

                    //TODO: preform firebase auth login
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      
    );
  }
  @override
    void dispose() {
      _email.dispose();
      _password.dispose();
      super.dispose();
    }
}

class Register extends StatefulWidget {
  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
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
              icon: Icon(Icons.email),
              hintText: 'מה המייל שלך?',
              labelText: 'מייל',
            ),
            // ignore: missing_return
            validator: (mail) {
              if (mail == null || mail.isEmpty) {
                return 'צריך לכתוב משהו פה';
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
                return 'צריך לכתוב משהו פה';
              }
              if (User.length < 4) {
                return 'בחר שם משתמש ארוך יותר';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.circle),
              hintText: 'בחר ססמא',
              labelText: 'ססמא',
            ),
            validator: (pass) {
              if (pass == null || pass.isEmpty) {
                return 'צריך לכתוב משהו פה';
              }
              if (pass.length < 6) {
                return 'ססמא ארוכה יותר בבקשה';
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPass()),
                );
              },
              child: Text('forgot password'),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class ChangePage extends StatelessWidget {
  //const ChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return PageView(
      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
      /// Use [Axis.vertical] to scroll vertically.
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        Center(
          child: Login(),
        ),
        Center(
          child: Register(),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangePage(),
    );
  }
}

class ForgotPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("שכחתי ססמא"),
      ),
      body: Center(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.payments_sharp),
              hintText: 'מה המייל שלך',
              labelText: 'מייל',
            ),
            onSaved: (mail) {
              //בדוק עם השרת וכו
            },
            validator: (mail) {
              if (mail == null || mail.isEmpty) {
                return 'צריך לכתוב משהו פה';
              }
              if (RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(mail)) {
                return 'מייל לא תקין';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('חזור חזרה'),
          ),
        ],
      )),
    );
  }
}
