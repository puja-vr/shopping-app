import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/components/vertical_bar.dart';
import 'package:shopping_app/screens/details/images.dart';
import 'package:shopping_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/shared/constants.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  final String hid;
  DetailsScreen({this.hid = ''});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DatabaseService _firebaseServices = DatabaseService();
  late dynamic docData;

  _snackBar({text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: EdgeInsets.fromLTRB(20, 7, 0, 7),
      content: Text(text, style: TextStyle(color: kwhite, fontSize: 16)),
      backgroundColor: kpurple,
      duration: defaultDuration,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseServices.houseCollection
            .doc(widget.hid)
            .get()
            .then((DocumentSnapshot docSnap) {
          if (docSnap.exists) {
            docData = docSnap.data();
          } else {
            print('Document does not exist on the database');
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List images = docData['images'];

            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
              ),
              body: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  ImageSwipe(hid: docData['hid'], images: images),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "${docData['title']}",
                      style: TextStyle(
                        color: kpurple,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_rounded),
                        SizedBox(width: 10),
                        Text(
                          "${docData['address']}",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "${docData['description']}",
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "PRICE",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kblack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "BHK",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kblack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "SQFT",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kblack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            VerticalBar(),
                            VerticalBar(),
                            VerticalBar(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rs. ${docData['price']} C",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kpurple[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${docData['bhk']}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kpurple[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${docData['sqft']}",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: kpurple[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "RATING",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(width: 100),
                            Text(
                              "${docData['rating']}",
                              style: TextStyle(fontSize: 18.0, color: kpurple),
                            ),
                          ],
                        ),
                        RatingBar.builder(
                          initialRating: docData['rating'],
                          minRating: 1,
                          itemSize: 35,
                          ignoreGestures: true,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.only(right: 3),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) => print(rating),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              floatingActionButton: footerButtons(context),
            );
          }

          // Loading State
          return Loading();
        });
  }

  Widget footerButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: Icon(Icons.star),
          onPressed: () async {
            await _firebaseServices.addToFav(hid: docData['hid']);
            _snackBar(text: "Added to favourites");
          },
          heroTag: "fab2",
          backgroundColor: Colors.purpleAccent,
          tooltip: 'Add to Favorites',
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        SizedBox(height: 20),
        FloatingActionButton(
          child: Icon(Icons.add_shopping_cart),
          onPressed: () async {
            await _firebaseServices.addToCart(hid: docData['hid']);
            _snackBar(text: "Added to the cart");
          },
          heroTag: "fab1",
          backgroundColor: kpurple,
          tooltip: 'Add to Cart',
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
