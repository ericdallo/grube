import 'package:flutter/material.dart';

class GameTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'GRUBE',
      style: TextStyle(
        fontSize: 40,
        color: Colors.black,
      ),
    );
  }
}

class StartGame extends StatelessWidget {
  final VoidCallback onPressed;

  StartGame({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        "PLAY",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
 
}
