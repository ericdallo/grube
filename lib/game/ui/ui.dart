import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/state.dart';
import 'package:grube/game/ui/components/top.dart';
import 'package:grube/game/ui/screen.dart';
import 'package:grube/game/ui/screens/game_over.dart';
import 'package:grube/game/ui/screens/loading.dart';
import 'package:grube/game/ui/screens/menu.dart';
import 'package:grube/game/ui/screens/playing.dart';

class UI extends StatelessWidget {
  final GameManager gameManager;

  UI(this.gameManager);

  Widget menuScreen() {
    return MenuScreen(
      onPlayPressed: () {
        gameManager.stateProvider.changeScreen(UIScreen.connecting);
        gameManager.start();
      },
    );
  }

  Widget connectingScreen() {
    return const Positioned.fill(
      child: const Loading("CONNECTING"),
    );
  }

  Widget reconnectingScreen() {
    return const Positioned.fill(
      child: const Loading("RECONNECTING"),
    );
  }

  Widget playingScreen() {
    return const PlayingScreen(const TopUI());
  }

  Widget gameOverScreen() {
    return GameOverScreen(
      const TopUI(),
      onRespawnPressed: () {
        gameManager.game.respawn();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var gameStateProvider = GameStateProvider.of(context);
    return Column(
      children: <Widget>[
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            children: [
              menuScreen(),
              connectingScreen(),
              playingScreen(),
              reconnectingScreen(),
              gameOverScreen(),
            ],
            index: gameStateProvider.currentScreen().index,
          ),
        ),
      ],
    );
  }
}
