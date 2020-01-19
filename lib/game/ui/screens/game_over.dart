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
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
