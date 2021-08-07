import 'package:shopping_app/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/cart/cart_screen.dart';
import 'package:shopping_app/screens/cart/fav_screen.dart';
import 'package:shopping_app/screens/others/contactUs_screen.dart';
import 'package:shopping_app/screens/home/home_screen.dart';
import 'package:shopping_app/screens/others/settings_screen.dart';
import 'package:shopping_app/screens/starters/landing_screen.dart';
import 'package:shopping_app/screens/starters/signUp_screen.dart';
import 'package:shopping_app/screens/starters/splash_screen.dart';
import 'package:shopping_app/screens/starters/signIn_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        LandingScreen.routeName: (context) => LandingScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        CartScreen.routeName: (context) => CartScreen(),
        FavScreen.routeName: (context) => FavScreen(),
        ContactUsScreen.routeName: (context) => ContactUsScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        //DetailsScreen.routeName: (context) => DetailsScreen(),
        //ProfileScreen.routeName: (context) => ProfileScreen(),
      },
    );
  }
}
