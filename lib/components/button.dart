import 'package:flutter/material.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenSize.screenWidth * 0.8,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
        onPressed: () {
          press();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: kwhite,
            onPrimary: Colors.purple[800],
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            )),
      ),
    );
  }
}
