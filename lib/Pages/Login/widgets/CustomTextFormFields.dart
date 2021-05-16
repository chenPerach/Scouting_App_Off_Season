import 'package:flutter/material.dart';

class FormPasswordField extends TextFormField {
  final TextEditingController controller;
  FormPasswordField({this.controller})
      : super(
            obscureText: true,
            decoration:
                _MyInputDecoration(labelText: "password"),
            validator: (pass) {
              if (pass == null || pass.isEmpty) {
                return "empty";
              }
              if (!RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$")
                  .hasMatch(pass)) {
                return "not secure enough";
              }
              return null;
            },
            controller: controller);
}

class FormEmailField extends TextFormField {
  final TextEditingController controller;
  FormEmailField({this.controller})
      : super(
            keyboardType: TextInputType.emailAddress,
            decoration: _MyInputDecoration(
                labelText: "email",hintText: "example@gmail.com"),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "empty";
              }
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(email)) {
                return "invalid email";
              }
              return null;
            },
            controller: controller);
}
class FormNameField extends TextFormField {
  final TextEditingController controller;
  FormNameField({this.controller})
      : super(
            keyboardType: TextInputType.emailAddress,
            decoration: _MyInputDecoration(
                labelText: "name"),
            validator: (name) {
              if (name == null || name.isEmpty) {
                return "empty";
              }
              return null;
            },
            controller: controller);
}
class _MyInputDecoration extends InputDecoration{
  final String hintText,labelText;
  _MyInputDecoration({this.hintText,this.labelText}):
  super(
    hintText: hintText,
    labelText: labelText,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
  );
}
