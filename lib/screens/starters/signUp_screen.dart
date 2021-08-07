import 'package:flutter/material.dart';
import 'package:shopping_app/screens/starters/form.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        height: double.infinity,
        color: kpurple[50],
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: ScreenSize.screenHeight * 0.04),
              Text("Register Account", style: headingStyle),
              Text(
                "Register using email and password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize.screenHeight * 0.08),
              SignForm(signIn: false),
              SizedBox(height: ScreenSize.screenHeight * 0.08),
              Text(
                'By continuing your confirm that you agree\nwith our Term and Condition',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
