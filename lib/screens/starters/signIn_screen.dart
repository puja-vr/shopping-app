import 'package:flutter/material.dart';
import 'package:shopping_app/screens/starters/form.dart';
import 'package:shopping_app/screens/starters/signUp_screen.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Container(
        height: double.infinity,
        color: kpurple[50],
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenSize.screenHeight * 0.04),
              Text(
                "Welcome Back",
                style: headingStyle,
              ),
              Text(
                "Sign in with your email and password",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ScreenSize.screenHeight * 0.08),
              SignForm(signIn: true),
              SizedBox(height: ScreenSize.screenHeight * 0.08),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: kpurple,
                  ),
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, SignUpScreen.routeName),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: kpurple,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign up',
                            style: TextStyle(color: Colors.blue, fontSize: 17))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
