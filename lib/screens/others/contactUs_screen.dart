import 'package:flutter/material.dart';
import 'package:shopping_app/shared/constants.dart';
import 'package:shopping_app/shared/screen_size.dart';

class ContactUsScreen extends StatelessWidget {
  static String routeName = "/contact_us";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpurple[800],
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Headoffice Address", style: Cheading),
            textContainer('11, 70 Feet Road, Jawahar Nagar, Chennai -	600082'),
            SizedBox(height: 20),
            Text("Call Us", style: Cheading),
            textContainer('1800 345 678'),
            SizedBox(height: 20),
            Text("Email Us", style: Cheading),
            textContainer('contact@gruhamart.in'),
            SizedBox(height: 20),
            Text("Website", style: Cheading),
            textContainer('https://gruhamart.com'),
            SizedBox(height: 20),
            Text("Follow Us", style: Cheading),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imageContainer("assets/instagram.png"),
                SizedBox(width: 20),
                imageContainer("assets/twitter.png"),
                SizedBox(width: 20),
                imageContainer("assets/facebook.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container imageContainer(String image) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenSize.screenWidth * 0.2,
      height: ScreenSize.screenWidth * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: kpurple[100]),
      child: Image.asset(image),
    );
  }

  Container textContainer(String text) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(15),
      width: ScreenSize.screenWidth * 0.8,
      decoration: BoxDecoration(
          border: Border.all(color: kwhite, width: 2),
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent),
      child: Text(text, style: Ccontent),
    );
  }
}
