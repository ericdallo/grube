import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/game/manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameManager gameManager = GameManager();

    return MaterialApp(
      title: 'Grube',
      theme: ThemeData(fontFamily: 'PressStart2P'),
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        child: Scaffold(
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
        ), onWillPop: gameManager.onBackPressed,
      ),
    );
  }
}
