import 'package:flutter/material.dart';
import 'package:grube/game/ui/components/button.dart';
import 'package:grube/game/ui/components/top.dart';

class GameOverScreen extends StatelessWidget {
  final TopUI topUI;
  final VoidCallback onRespawnPressed;

  GameOverScreen(this.topUI, {@required this.onRespawnPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          topUI,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Title(),
                _Respawn(onPressed: onRespawnPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
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

class _Respawn extends GameButton {
  _Respawn({@required VoidCallback onPressed})
      : super(
          text: "RESPAWN",
          fontSize: 24,
          onPressed: onPressed,
        );
}
