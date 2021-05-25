import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot password"),
      ),
      body: Form(
        key: key,
        child: Center(
          child: Container(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "password reset",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 8),
                FormEmailField(
                  controller: email,
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState.validate()) {
                      Navigator.pop(context,email.text);
                    }
                  },
                  child: Text('reset'),
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
    email.dispose();
    super.dispose();
  }
}
