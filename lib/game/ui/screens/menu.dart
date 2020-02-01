import 'package:flutter/material.dart';
import 'package:grube/game/ui/components/button.dart';

class MenuScreen extends StatelessWidget {
  final VoidCallback onPlayPressed;

  MenuScreen({@required this.onPlayPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Title(),
          _Play(
            onPressed: onPlayPressed,
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
      'GRUBE',
      style: TextStyle(
        fontSize: 40,
        color: Colors.black,
      ),
    );
  }
}

class _Play extends GameButton {
  _Play({@required VoidCallback onPressed})
      : super(
          text: "PLAY",
          fontSize: 24,
          onPressed: onPressed,
        );
}
