import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/screens/home/home_screen.dart';
import 'package:shopping_app/screens/starters/signIn_screen.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = "/land";

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${streamSnapshot.error}"),
            ),
          );
        }

        if (streamSnapshot.connectionState == ConnectionState.active) {
          Object? _user = streamSnapshot.data;

          if (_user == null) {
            return SignInScreen();
          } else {
            return HomeScreen();
          }
        }

        return Loading();
      },
    );
  }
}
