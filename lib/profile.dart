//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

String userid, useremail, userphotourl;

class ProfileContent extends StatefulWidget {
  @override
  _ProfileContentState createState() => _ProfileContentState();
}



class _ProfileContentState extends State<ProfileContent>{

  Future<Null> _function() async {
    User user = FirebaseAuth.instance.currentUser;

    userid = user.uid;
    useremail = user.email;
    userphotourl = "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png";

    }
  @override
  void initState() {
    super.initState();
    _function();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: userphotourl,
                height: 150.0,
                width: 150.0,
                fadeInDuration: const Duration(milliseconds: 1000),
                alignment: Alignment.topCenter,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 8.0),
              child: Text(
                "TEST",
                style: TextStyle(
                    fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              useremail,
              style: const TextStyle(fontSize: 18.0,color: Colors.blueAccent),
            ),
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

}


