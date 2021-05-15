import 'package:flutter/material.dart';

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
