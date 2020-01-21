import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/game/manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GameManager gameManager = GameManager();

  runApp(
    MaterialApp(
      title: 'Grube',
      theme: ThemeData(fontFamily: 'PressStart2P'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: gameManager.game.widget,
            ),
            Positioned.fill(
              child: gameManager.gameUI,
            )
          ],
        ),
      ),
    ),
  );
}
