import 'package:flutter/material.dart';
import 'package:shopping_app/components/button.dart';
import 'package:shopping_app/screens/starters/landing_screen.dart';
import 'package:shopping_app/shared/screen_size.dart';
import 'package:shopping_app/shared/constants.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return SafeArea(
      child: Material(
        color: Colors.purple[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              "GRUHA",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                color: kwhite,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              "Welcome to Gruha!\nMake your dream true by just staying at home",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.blue,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            Image.asset(
              'assets/splash.jpg',
              height: getProportionateScreenHeight(350),
            ),
            Button(
              text: "Let's start!",
              press: () {
                Navigator.pushNamed(context, LandingScreen.routeName);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }
}
