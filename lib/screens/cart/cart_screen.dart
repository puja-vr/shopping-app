import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/button.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/screens/cart/list_item.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';
import 'package:shimmer/shimmer.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();

  static _CartScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CartScreenState>();
}

class _CartScreenState extends State<CartScreen> {
  DatabaseService _firebaseServices = DatabaseService();
  bool showBottomcard = false;
  bool completeProfile = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(defaultDuration, () {
      setState(() {
        showBottomcard = true;
      });
    });
    _firebaseServices.userCollection
        .doc(_firebaseServices.getUserId())
        .get()
        .then((DocumentSnapshot docSnap) {
      if (docSnap.get('phone') == 0) completeProfile = true;
    });
  }

  void minusPrice(double p) {
    setState(() => totalPrice -= p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpurple[50],
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firebaseServices.userCollection
                  .doc(_firebaseServices.getUserId())
                  .collection("Cart")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                }
                totalPrice = 0;
                if (snapshot.data!.size == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/sadhouse.png", height: 150),
                      SizedBox(height: 20),
                      Text(
                        "Your cart is empty!",
                        style: TextStyle(color: kpurple[800], fontSize: 18),
                      )
                    ],
                  );
                }
                return ListView(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  children: snapshot.data!.docs.map((doc) {
                    return ListItem(hid: doc['hid'], cart: true);
                  }).toList(),
                );
              },
            ),
          ),
          showBottomcard ? bottomCard() : loadingCard(),
        ],
      ),
    );
  }

  Container bottomCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: kpurple[800],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1000),
            blurRadius: 100,
            spreadRadius: 100,
            color: kpurple,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: "Total:\n",
              style: TextStyle(fontSize: 20, color: kwhite, height: 1.5),
              children: [
                TextSpan(
                  text: "Rs. ${totalPrice.toStringAsFixed(2)} C",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(210),
            child: Button(
              text: "Proceed",
              press: () {
                if (totalPrice != 0) popUp();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingCard() {
    return Shimmer.fromColors(
      baseColor: kpurple.shade800,
      highlightColor: Colors.purpleAccent,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: kpurple[800],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1000),
              blurRadius: 100,
              spreadRadius: 100,
              color: kpurple,
            )
          ],
        ),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                text: " \n",
                style: TextStyle(fontSize: 20, height: 1.5),
                children: [
                  TextSpan(
                    text: " ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Button(
                text: " ",
                press: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  popUp() {
    String image, text;
    if (completeProfile) {
      image = "assets/profile.png";
      text = "Please complete your profile to proceed!";
    } else {
      image = "assets/house.png";
      text =
          "Our team will contact you for further procedure and the floor plan will be sent.";
    }
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        actionsPadding: EdgeInsets.fromLTRB(0, 0, 20, 10),
        backgroundColor: kpurple,
        elevation: 30,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text(
          "Thank you from Gruha Mart!",
          style: TextStyle(
              fontSize: 20, color: kwhite, fontWeight: FontWeight.w900),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 200,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 19,
                  color: kwhite,
                  fontWeight: FontWeight.w700,
                  height: 1.5),
            ),
          ],
        ),
        actions: <Widget>[
          InkWell(
            child: IconButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                icon: Icon(
                  Icons.check_circle,
                  color: kwhite,
                  size: 40,
                )),
          ),
        ],
      ),
    );
  }
}
