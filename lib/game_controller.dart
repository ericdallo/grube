import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:grube/game_data.dart';
import 'package:grube/socket_manager.dart';

class GameController extends Game {
  SocketManager socketManager;
  GameData gameData;

  Size screenSize;
  double tileSize;

  Random random;

  GameController() {
    initialize();
  }

  void initialize() async {
    socketManager = SocketManager(this);

    resize(await Flame.util.initialDimensions());
  }

  @override
  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    if (gameData != null) {
      gameData.enemies.forEach((enemyId, enemy) => enemy.render(c));
      gameData.player.render(c);
    }
  }

  @override
  void update(double t) {
    if (gameData != null) {
      gameData.enemies.forEach((enemyId, enemy) => enemy.update(t));
      gameData.player.update(t);
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 10;
  }

  void onPanUpdate(DragUpdateDetails details) {
    gameData.player.move(details);
  }

  void onGameUpdate(GameData gameData) {
    this.gameData = gameData;
  }
}
