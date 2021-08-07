import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/screens/details/details_screen.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/screens/cart/cart_screen.dart';

class ListItem extends StatelessWidget {
  late final String hid;
  late final bool cart;
  ListItem({required this.hid, required this.cart});

  final DatabaseService _firebaseServices = DatabaseService();
  late final dynamic docData;
  final CartScreen c = CartScreen();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      shadowColor: kpurple,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(hid: hid),
              ));
        },
        child: FutureBuilder(
          future: _firebaseServices.houseCollection
              .doc(hid)
              .get()
              .then((DocumentSnapshot docSnap) {
            if (docSnap.exists) {
              docData = docSnap.data();
            } else {
              print('Document does not exist on the database');
            }
          }),
          builder: (context, productSnap) {
            if (productSnap.hasError) {
              return Container(
                child: Center(
                  child: Text("${productSnap.error}"),
                ),
              );
            }

            if (productSnap.connectionState == ConnectionState.done) {
              totalPrice += docData['price'];
              print(totalPrice);
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: docData['images'][0],
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                                text: "${docData['title']}\n",
                                style: TextStyle(
                                    height: 1.5,
                                    fontSize: 16.0,
                                    color: kblack,
                                    fontWeight: FontWeight.w600),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: "Rs. ${docData['price']} C\n",
                                    style: TextStyle(color: kpurple),
                                  ),
                                  TextSpan(
                                      text:
                                          "${docData['bhk']} BHK - ${docData['sqft']} sqft"),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      child: IconButton(
                        onPressed: () {
                          cart
                              ? _firebaseServices.removeFromCart(
                                  hid: docData['hid'])
                              : _firebaseServices.removeFromFav(
                                  hid: docData['hid']);
                          if (cart)
                            CartScreen.of(context)!
                                .minusPrice(docData['price']);
                        },
                        icon: cart
                            ? Icon(
                                Icons.close_rounded,
                                color: Colors.redAccent,
                                size: 40,
                              )
                            : Icon(
                                Icons.star,
                                color: kpurple,
                                size: 30,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Loading();
          },
        ),
      ),
    );
  }
}
