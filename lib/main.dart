import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GameStateProvider(
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameManager gameManager = GameManager.instance(context);

    return MaterialApp(
      title: 'Grube',
      theme: ThemeData(fontFamily: 'PressStart2P'),
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onDoubleTap: gameManager.game.onDoubleTap,
        onHorizontalDragStart: gameManager.game.onDragStart,
        onHorizontalDragUpdate: gameManager.game.onDragUpdate,
        onHorizontalDragEnd: gameManager.game.onDragEnd,
        onVerticalDragStart: gameManager.game.onDragStart,
        onVerticalDragUpdate: gameManager.game.onDragUpdate,
        onVerticalDragEnd: gameManager.game.onDragEnd,
        child: WillPopScope(
          child: Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: gameManager.game.widget,
                ),
                Positioned.fill(
                  child: gameManager.ui,
                )
              ],
            ),
          ),
          onWillPop: gameManager.onBackPressed,
        ),
      ),
    );
  }
}
