import 'package:flutter/material.dart';
import 'package:grube/game/ui/components/top.dart';

class PlayingScreen extends StatelessWidget {
  final TopUI topUI;

  PlayingScreen(this.topUI);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          topUI,
        ],
      ),
    );
  }
}
