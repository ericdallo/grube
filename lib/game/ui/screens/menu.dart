import 'package:flutter/material.dart';
import 'package:grube/game/ui/components/button.dart';

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

class Play extends GameButton {

  Play({@required VoidCallback onPressed})
      : super(
          text: "PLAY",
          fontSize: 24,
          onPressed: onPressed,
        );
}
