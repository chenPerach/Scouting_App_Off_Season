import 'package:flutter/material.dart';

class ForgotPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot password"),
      ),
      body: Center(
          child: Column(
        children: [
          const Image(
            image: NetworkImage(
                'https://i.pinimg.com/originals/79/3d/c9/793dc92fc5b0e5fc85c9a1e31efa0749.jpg'),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.payments_sharp),
                hintText: 'email',
                labelText: 'example@Email.com',
              ),
              onSaved: (mail) {
                //בדוק עם השרת וכו
              },
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
                      Navigator.pop(context);
                    },
                    child: Text('return'),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
