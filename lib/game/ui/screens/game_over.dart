import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'GAME OVER',
      style: TextStyle(
        fontSize: 40,
        color: Colors.black,
      ),
    );
  }
}

class Respawn extends StatelessWidget {
  final VoidCallback onPressed;

  Respawn({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        "Respawn",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
