import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      child: Center(
        child: SpinKitCubeGrid(
          color: Colors.deepPurple,
          size: 75.0,
        ),
      ),
    );
  }
}
