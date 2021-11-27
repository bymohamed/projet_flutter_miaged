//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Profile'),
            FutureBuilder(
              initialData: "Loading text..",
              future: getEmail(),
              builder: (BuildContext context, AsyncSnapshot<String> text) {
                return new Text(text.data);
              },
            ),
            Container(
                width: 200.0,
                child: TextFormField(
                    decoration: new InputDecoration.collapsed(
                        hintText: 'old password'
                    )
                )
            ),
            Container(
                width: 200.0,
                child: TextFormField(
                  decoration: new InputDecoration.collapsed(
                      hintText: 'new password'
                  ),

                )
            ),
            Container(
                width: 200.0,
                child: TextFormField(
                    decoration: new InputDecoration.collapsed(
                        hintText: 'repeat new password'
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    User user = await FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user.updatePassword(password).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  Future<String> getEmail() async {
    User user = await FirebaseAuth.instance.currentUser;
    return user.email;
  }
}
