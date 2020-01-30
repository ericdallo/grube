import 'package:flutter/material.dart';
import 'package:grube/game/ui/components/button.dart';

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

class Respawn extends GameButton {

  Respawn({@required VoidCallback onPressed})
      : super(
          text: "RESPAWN",
          fontSize: 24,
          onPressed: onPressed,
        );
}
