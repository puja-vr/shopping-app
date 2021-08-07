import 'package:flutter/material.dart';
import 'package:shopping_app/shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        color: kpurple[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/settings.png", height: 300),
            SizedBox(height: 20),
            Text(
              "Under Construction!",
              textAlign: TextAlign.center,
              style: TextStyle(color: kpurple[800], fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
