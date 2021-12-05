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
        title: Text('Panier'),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Column(
              children: [
                for (var element in HomeContent.panier)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text(element['nom']),
                          Text("Taille : " + element['taille']),
                        ]),
                        Image.network(element['url_photo'], height: 50),
                        Text("Prix : " + element['prix']),
                        TextButton(
                            onPressed: () => {
                                  supprimerElementAuPanier(element),
                                  setState(() {})
                                },
                            child: Text("supprimer")),
                      ])]),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text("Somme : ",
                      style: TextStyle(height: 5, fontSize: 25)),
                    Text(somme().toString(),
                        style: TextStyle(height: 5, fontSize: 25))
                  ],
                ))
              ],

          )),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileContent()));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void supprimerElementAuPanier(Map o) {
    HomeContent.panier.remove(o);
  }

  double somme() {
    double sum = 0;
    for (var element in HomeContent.panier)
      sum += double.parse(element['prix']);
    return sum;
  }
}
