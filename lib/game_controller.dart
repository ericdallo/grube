import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grube/direction.dart';
import 'package:grube/texts/game_over.dart';
import 'package:grube/enums.dart';
import 'package:grube/world.dart';
import 'package:grube/game/manager.dart';

class GameController extends BaseGame {
  GameManager gameManager;
  GameOverText gameOverText;

  Size screenSize;

  Random random;

  bool canMove;

  GameController(this.gameManager) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  @override
  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    if (!gameManager.loaded) {
      return;
    }

    var world = World.instance;

    world.enemies.forEach((enemy) => enemy.render(c));
    world.player.render(c);

    if (!world.player.live) {
      gameOverText.render(c);
    }
  }

  @override
  void update(double t) {
    if (!gameManager.loaded) {
      return;
    }

    var world = World.instance;

    world.enemies.forEach((enemy) => enemy.update(t));
    world.player.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.screenSize = size;
    this.gameOverText = GameOverText(screenSize);
  }

  void onDoubleTap() {
    if (!gameManager.loaded) {
      return;
    }
    World.instance.player.shoot();
  }

  void onDragStart(DragStartDetails details) {
    this.canMove = true;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canMove && gameManager.loaded) {
      World.instance.player.move(_toDirection(details));
    }
    this.canMove = false;
  }

  void onDragEnd(DragEndDetails details) {
    this.canMove = true;
  }

  void playerMoved(Direction direction, Position position) async {
    this.gameManager.socketManager.send("move-player", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y
    });
  }

  void playerShot(Direction direction, Position position) async {
    this.gameManager.socketManager.send("player-shoot", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y,
    });
  }

  Direction _toDirection(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      return Direction.right;
    }

    if (details.delta.dx < 0) {
      return Direction.left;
    }

    if (details.delta.dy > 0) {
      return Direction.down;
    }

    return Direction.up;
  }
}
