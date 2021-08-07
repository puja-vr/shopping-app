import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/screens/cart/list_item.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/shared/constants.dart';

class FavScreen extends StatefulWidget {
  static String routeName = "/favourites";

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  DatabaseService _firebaseServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: Container(
        color: kpurple[50],
        child: StreamBuilder(
          stream: _firebaseServices.userCollection
              .doc(_firebaseServices.getUserId())
              .collection("Favourites")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            if (snapshot.data!.size == 0) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset("assets/sadhouse.png", height: 150),
                  SizedBox(height: 20),
                  Text(
                    "Your have no favourites!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kpurple[800], fontSize: 18),
                  )
                ],
              );
            }
            return ListView(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              children: snapshot.data!.docs.map((doc) {
                return ListItem(hid: doc['hid'], cart: false);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
