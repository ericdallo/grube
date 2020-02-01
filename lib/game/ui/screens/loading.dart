import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final String text;

  const Loading(this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: Center()),
        const Expanded(child: Center()),
        const Expanded(
          child: SpinKitFadingCube(
            color: Colors.black,
            size: 50.0,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        const Expanded(child: Center()),
      ],
    );
  }
}
