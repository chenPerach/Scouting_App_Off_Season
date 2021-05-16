import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';
import 'package:scouting_app_2/Pages/Login/widgets/forgotPass.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _password = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Image(
                    image: NetworkImage(
                        'https://i.pinimg.com/originals/79/3d/c9/793dc92fc5b0e5fc85c9a1e31efa0749.jpg'),
                  ),
                  FormEmailField(controller: _email,),
                  SizedBox(
                    height: 10,
                  ),
                  FormPasswordField(controller: _password,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState.validate()) {
                              var bloc =
                                  BlocProvider.of<AuthenticationBloc>(context);
                              bloc.add(AuthLogin(
                                  email: _email.text,
                                  password: _password.text));
                            }
                          },
                          child: Text('log in'),
                        ),
                      ),
                      TextButton(
                        child: Text("Forgot password"),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPass()),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
