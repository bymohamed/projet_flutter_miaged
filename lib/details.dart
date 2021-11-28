//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp2_note/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class DetailsContent extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailsContent({Key key, this.data}) : super(key: key);

  @override
  _DetailsContentState createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Column(
              children: [
                Text(widget.data['nom']),
                Image.network(widget.data['url_photo'], height: 450),
                Text("Prix : " + widget.data['prix']),
                Text("Taille : " + widget.data['taille']),
                FlatButton(
                    onPressed: ajouter_au_panier,
                    child: Container(
                        color: Colors.cyan,
                        child: const Text("ajouter au panier"))),
              ],
            ),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.green,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//          height: 80,
//          width: 150,
//          decoration: BoxDecoration(
//              color: Colors.lightGreen, borderRadius: BorderRadius.circular(10)),

                    children: [
                      FlatButton(
                          onPressed: () {
                            _signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LOGIN()),
                            );
                          },
                          child: Text('Logout')),
                      FlatButton(
                          onPressed: () {
                            _navigateToNextScreen(context);
                          },
                          child: Text('Profile')),
                    ]),
              ),
            )),
          ])),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileContent()));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void ajouter_au_panier() {}
}
