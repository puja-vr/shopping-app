import 'package:flutter/material.dart';
import 'package:shopping_app/components/drawer.dart';
import 'package:shopping_app/screens/cart/cart_screen.dart';
import 'package:shopping_app/screens/cart/fav_screen.dart';
import 'package:shopping_app/screens/home/body.dart';
import 'package:shopping_app/shared/constants.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gruha Mart'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.star),
              tooltip: 'Favorites',
              onPressed: () {
                Navigator.pushNamed(context, FavScreen.routeName);
              },
            ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              tooltip: 'Cart',
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ],
          bottom: TabBar(
              labelColor: kwhite,
              unselectedLabelColor: kpurple,
              isScrollable: true,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.purpleAccent),
              tabs: [
                Tab(text: "One Storey House"),
                Tab(text: "Two Storey House"),
                Tab(text: "Office"),
                Tab(text: "Others")
              ]),
        ),
        drawer: SideDrawer(),
        body: TabBarView(
          children: [
            Body(choice: 1),
            Body(choice: 2),
            Body(choice: 3),
            Body(choice: 4),
          ],
        ),
      ),
    );
  }
}
