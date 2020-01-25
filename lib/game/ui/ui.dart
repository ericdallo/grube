import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/ui/screens/game_over.dart';
import 'package:grube/game/ui/screens/loading.dart';
import 'package:grube/game/ui/screens/menu.dart';
import 'package:grube/game/ui/screens/playing.dart';

class GameUI extends StatefulWidget {
  final _GameUIState state = _GameUIState();

  State<StatefulWidget> createState() => state;

  void score(int score) {
    state.score = score;
    state.update();
  }

  void life(int life) {
    state.life = life;
    state.update();
  }

  void staminaTime(int staminaTime) {
    state.visible = true;
    state.width = 0;
    state.time = staminaTime;
    state.update();
  }

  void staminaCharged() {
    state.visible = false;
    state.width = 100;
    state.time = 0;
    state.update();
  }

  void changeScreen(UIScreen screen) {
    state.currentScreen = screen;
    state.update();
  }
}

const MAX_LIFE = 3;

class _GameUIState extends State<GameUI> with WidgetsBindingObserver {
  Game game;
  int score = 0;
  int life = MAX_LIFE;
  UIScreen currentScreen = UIScreen.menu;

  int time = 0;
  bool visible = false;
  double width = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  Widget topUI() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            children: [
              Lifes(
                currentLife: life,
                maxLife: MAX_LIFE,
              ),
              Expanded(child: Center()),
              Score(score),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Row(
              children: [
                Stamina(
                  innerWidth: width,
                  time: time,
                  visible: visible,
                ),
                Expanded(child: Center()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget menuScreen() {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GameTitle(),
          StartGame(
            onPressed: (() {
              currentScreen = UIScreen.connecting;
              update();
              game.start();
            }),
          ),
        ],
      ),
    );
  }

  Widget connectingScreen() {
    return Positioned.fill(
      child: Loading("CONNECTING"),
    );
  }

  Widget reconnectingScreen() {
    return Positioned.fill(
      child: Loading("RECONNECTING"),
    );
  }

  Widget playingScreen() {
    return Positioned.fill(
      child: Column(
        children: [
          topUI(),
        ],
      ),
    );
  }

  Widget gameOverScreen() {
    return Positioned.fill(
      child: Column(
        children: [
          topUI(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GameOver(),
                Respawn(
                  onPressed: (() {
                    game.respawn();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            index: currentScreen.index,
          ),
        ),
      ],
    );
  }
}

enum UIScreen {
  menu,
  connecting,
  playing,
  reconnecting,
  gameOver,
}
