//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp2_note/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
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
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance.collection('articles').snapshots(),
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

  var articles = FirebaseFirestore.instance
      .collection('articles')
      .get()
      .then((QuerySnapshot querySnapshot) {
         querySnapshot.docs.forEach((doc) {
           debugPrint(doc["nom"]);
    });
  });
}
