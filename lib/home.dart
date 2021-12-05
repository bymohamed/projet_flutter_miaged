//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp2_note/details.dart';
import 'package:tp2_note/panier.dart';
import 'package:tp2_note/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class HomeContent extends StatefulWidget {
  static List<Map> panier = new List();

  @override
  _HomeContentState createState() => _HomeContentState();
}


class _HomeContentState extends State<HomeContent> {
  Stream articles = FirebaseFirestore.instance.collection('articles').snapshots();

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


                    DropdownButton<String>(
                      items: <String>['tous','homme', 'femme', 'enfant'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text("filtre"),
                      onChanged: (S){
                        if(S!="tous")
                          articles = FirebaseFirestore.instance.collection('articles').where("categorie", isEqualTo: S).snapshots();
                        else
                          articles = FirebaseFirestore.instance.collection('articles').snapshots();
                        setState(() {});
                      },
                    ),


                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: articles,
                      builder: (_, snapshot) {
                        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

                        if (snapshot.hasData) {
                          final docs = snapshot.data.docs;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return ListTile(
                                title: Text(data['nom']),
                                subtitle: Text(data['prix']),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => DetailsContent(data: data),
                                      ));
                                },
                              );
                            },
                          );
                        }

                        return Center(child: CircularProgressIndicator());
                      },
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
                            _navigateToProfile(context);
                          },
                          child: Text('Profile')),
                      FlatButton(
                          onPressed: () {
                            _navigateToPanier(context);
                          },
                          child: Text('Panier'))
                    ]),
              ),
            )),
          ])),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ProfileContent()));
  }

  void _navigateToPanier(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PanierContent()));
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }






}

