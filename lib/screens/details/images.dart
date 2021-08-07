import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/shared/constants.dart';

class ImageSwipe extends StatefulWidget {
  final List images;
  final String hid;
  ImageSwipe({required this.hid, required this.images});

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.images.length; i++)
                Hero(
                  tag: "${widget.hid}",
                  child: Container(
                    child: CachedNetworkImage(
                      imageUrl: widget.images[i],
                      fit: BoxFit.contain,
                    ),
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.images.length; i++)
                  AnimatedContainer(
                    duration: kAnimationDuration,
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: kpurple,
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
