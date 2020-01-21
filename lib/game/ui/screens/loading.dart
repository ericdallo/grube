import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Center()),
        Expanded(child: Center()),
        Expanded(
          child: SpinKitFadingCube(
            color: Colors.black,
            size: 50.0,
          ),
        ),
        Expanded(
            child: Text(
          "LOADING",
          style: TextStyle(fontSize: 22),
        )),
        Expanded(child: Center()),
      ],
    );
  }
}
