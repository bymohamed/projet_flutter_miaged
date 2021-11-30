//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp2_note/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2_note/home.dart';
import 'package:firebase_database/firebase_database.dart';

import 'login.dart';

class PanierContent extends StatefulWidget {
  final Map<String, dynamic> data;
  const PanierContent({Key key, this.data}) : super(key: key);

  @override
  _PanierContentState createState() => _PanierContentState();
}

class _PanierContentState extends State<PanierContent> {
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
                for(var element in HomeContent.panier)
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Column(children: [
                    Text(element['nom']),
                    Text("Taille : " + element['taille']),
                  ]),
                  Image.network(element['url_photo'], height: 50),
                  Text("Prix : " + element['prix']),
                      TextButton(onPressed:() => {supprimerElementAuPanier(element), setState(() {})
                      }, child: Text("supprimer"))

                ]
                )


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


  void supprimerElementAuPanier(Map o){
    HomeContent.panier.remove(o);
  }



}
