import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/ui/state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(GameStateProvider(
    child: App(),
    data: GameState(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grube',
      theme: ThemeData(fontFamily: 'PressStart2P'),
      debugShowCheckedModeBanner: false,
      home: buildHome(context),
    );
  }

  Widget buildHome(BuildContext context) {
    GameManager gameManager = GameManager.instance(context);

    return WillPopScope(
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
    );
  }
}
