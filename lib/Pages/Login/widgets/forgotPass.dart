import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scouting_app_2/Pages/Login/bloc/authentication_bloc.dart';
import 'package:scouting_app_2/Pages/Login/widgets/CustomTextFormFields.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController email;
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
              children: [
                Image(
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/79/3d/c9/793dc92fc5b0e5fc85c9a1e31efa0749.jpg'),
                ),
                FormEmailField(
                  controller: email,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (key.currentState.validate()) {
                      var bloc = BlocProvider.of<AuthenticationBloc>(context);
                      bloc.add(AuthForgotPassword(email: email.text));
                      Navigator.pop(context);
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
    // TODO: implement dispose
    super.dispose();
  }
}
