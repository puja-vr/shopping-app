import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopping_app/screens/details/details_screen.dart';
import 'package:shopping_app/shared/constants.dart';

class GridItem extends StatelessWidget {
  late final int bhk, category, sqft;
  late final String hid, title, description, address, image1;
  late final double rating, price;

  GridItem({
    required this.hid,
    required this.title,
    required this.address,
    required this.bhk,
    required this.image1,
    required this.price,
    required this.rating,
    required this.sqft,
    required this.description,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(hid: hid)),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: kblack.withOpacity(.2),
              offset: Offset.zero,
              blurRadius: 15.0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "$hid",
              child: CachedNetworkImage(
                imageUrl: image1,
                fit: BoxFit.contain,
                height: 105,
                width: 150,
                alignment: Alignment.center,
              ),
            ),
            Text(
              "$title\n$address\n$bhk BHK\n$sqft sqft",
              style: TextStyle(
                height: 1.5,
                color: kblack,
                fontSize: 14,
              ),
            ),
            Text(
              'Rs. $price C',
              style: TextStyle(
                fontSize: 18,
                color: kpurple,
              ),
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  itemSize: 25,
                  ignoreGestures: true,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.zero,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) => print(rating),
                ),
                SizedBox(width: 5),
                Text('$rating'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
