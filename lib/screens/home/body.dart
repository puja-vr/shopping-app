import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/screens/home/grid_item.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class Body extends StatefulWidget {
  late final int choice;
  Body({required this.choice});

  @override
  _BodyState createState() => _BodyState(choice: choice);
}

class _BodyState extends State<Body> {
  late int choice;
  late String searchText;
  _BodyState({required this.choice}) {
    print(choice);
    switch (choice) {
      case 1:
        searchText = "Search one storey houses";
        break;
      case 2:
        searchText = "Search two storey houses";
        break;
      case 3:
        searchText = "Search offices, commercial buildings";
        break;
      case 4:
        searchText = "Search schools, shops, barns, etc.";
        break;
    }
  }

  late dynamic data;
  bool isfiltered = false;
  late String queryStr;
  List<int> _bhkList = [0, 1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(15)),
      child: Column(
        children: [
          searchAndFilter(),
          discountBanner(),
          grid(),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> grid() {
    return StreamBuilder(
      stream: isfiltered
          ? data
          : FirebaseFirestore.instance
              .collection('houses')
              .where('category', isEqualTo: choice)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        if (snapshot.data!.size == 0) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Image.asset("assets/sadhouse.png", height: 150),
              SizedBox(height: 20),
              Text(
                "No results found!",
                textAlign: TextAlign.center,
                style: TextStyle(color: kpurple[800], fontSize: 18),
              )
            ],
          );
        }
        return Flexible(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: snapshot.data!.docs.map((doc) {
              return GridItem(
                hid: doc['hid'],
                title: doc['title'],
                address: doc['address'],
                bhk: doc['bhk'],
                image1: doc['images'][0],
                price: doc['price'],
                rating: doc['rating'],
                sqft: doc['sqft'],
                description: doc['description'],
                category: doc['category'],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget searchAndFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: getProportionateScreenWidth(15)),
            decoration: BoxDecoration(
              color: kgreybg.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  queryStr = value;
                });
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: getProportionateScreenWidth(12)),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: searchText,
                  prefixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          width: ScreenSize.screenWidth * 0.15,
          margin: EdgeInsets.only(bottom: getProportionateScreenWidth(15)),
          decoration: BoxDecoration(
            color: kgreybg.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: searchButton(),
        ),
        SizedBox(width: 10),
        Container(
          width: ScreenSize.screenWidth * 0.15,
          margin: EdgeInsets.only(bottom: getProportionateScreenWidth(15)),
          decoration: BoxDecoration(
            color: kgreybg.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: filterButton(),
        ),
      ],
    );
  }

  Widget searchButton() {
    return IconButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            data = FirebaseFirestore.instance
                .collection("houses")
                .where('category', isEqualTo: choice)
                .where('title', isGreaterThanOrEqualTo: queryStr)
                .snapshots();
            isfiltered = true;
          });
        },
        icon: Icon(Icons.search, size: 28));
  }

  Widget filterButton() {
    return PopupMenuButton(
        icon: ImageIcon(AssetImage("assets/filter.png"), size: 28),
        color: kpurple[100],
        elevation: 20,
        enabled: true,
        onSelected: (int value) {
          setState(() {
            if (value == 0)
              isfiltered = false;
            else {
              data = FirebaseFirestore.instance
                  .collection('houses')
                  .where('category', isEqualTo: choice)
                  .where('bhk', isEqualTo: value)
                  .snapshots();
              isfiltered = true;
            }
          });
        },
        itemBuilder: (context) {
          return _bhkList.map((int bhk) {
            return PopupMenuItem(
              value: bhk,
              child: Text(
                (bhk == 0) ? "All" : "$bhk BHK",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }).toList();
        });
  }

  Widget discountBanner() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: getProportionateScreenWidth(15)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(20),
      ),
      decoration: BoxDecoration(
        color: kpurple[600],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(
              color: kwhite, fontWeight: FontWeight.bold, height: 1.5),
          children: [
            TextSpan(
              text: "Hurry up!\n",
              style: TextStyle(fontSize: 18),
            ),
            TextSpan(
              text: "Get Loan benefits!\n",
              style: TextStyle(fontSize: 24),
            ),
            TextSpan(
              text: "EMI options are available too!",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
