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
import 'package:grube/socket_manager.dart';

class GameController extends BaseGame {
  SocketManager socketManager;
  World world;
  GameOverText gameOverText;

  Size screenSize;

  Random random;

  bool canMove;

  GameController() {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());

    socketManager = SocketManager(this);
  }

  @override
  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    if (world != null) {
      world.enemies.forEach((enemy) => enemy.render(c));
      world.player.render(c);

      if (!world.player.live) {
        gameOverText.render(c);
      }
    }
  }

  @override
  void update(double t) {
    if (world == null) {
      return;
    }

    world.enemies.forEach((enemy) => enemy.update(t));
    world.player.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.screenSize = size;
    this.gameOverText = GameOverText(screenSize);
  }

  void onWorldUpdate(World world) {
    this.world = world;
  }

  void onDoubleTap() {
    if (world != null) {
      world.player.shoot();
    }
  }

  void onDragStart(DragStartDetails details) {
    this.canMove = true;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canMove) {
      world.player.move(_toDirection(details));
    }
    this.canMove = false;
  }

  void onDragEnd(DragEndDetails details) {
    this.canMove = true;
  }

  void playerMoved(Direction direction, Position position) async {
    this.socketManager.send("move-player", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y
    });
  }

  void playerShot(Direction direction, Position position) async {
    this.socketManager.send("player-shoot", {
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
