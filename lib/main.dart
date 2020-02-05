import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/app_state_manager.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameStateProvider(
      child: _GameApp(),
    );
  }
}

class _GameApp extends StatelessWidget {
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
        child: AppStateManager(),
      ),
    );
  }
}
