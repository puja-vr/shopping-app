import 'package:flutter/material.dart';
import 'package:shopping_app/shared/screen_size.dart';

late double? minPrice, maxPrice;
late int? minSqft = 1900, maxSqft = 2000;
late List fList;
double totalPrice = 0;
bool loading = false;
dynamic result;

const kwhite = Colors.white;
const kpurple = Colors.purple;
const kblack = Colors.black;
const kdeepPurple = Colors.deepPurple;
const kgreybg = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const defaultDuration = Duration(seconds: 2);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.purple[800],
  height: 1.5,
);

const TextStyle Cheading = TextStyle(
  fontSize: 22,
  color: kwhite,
  fontWeight: FontWeight.bold,
);
const TextStyle Ccontent = TextStyle(
  fontSize: 20,
  color: kwhite,
  fontWeight: FontWeight.bold,
  height: 1.5,
);

const TextStyle drawer = TextStyle(
  fontSize: 20,
  color: kdeepPurple,
);

// Form Errors
const String kSignInError = "Couldn't sign in with these credentials";
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
