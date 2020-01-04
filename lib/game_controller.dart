import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:grube/aspect_ratio.dart';
import 'package:grube/game_data.dart';
import 'package:grube/socket_manager.dart';

class GameController extends Game {
  SocketManager socketManager;
  World world;

  Size screenSize;
  AspectRatio aspectRatio;

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
      world.enemies.forEach((enemyId, enemy) => enemy.render(c));
      world.player.render(c);
    }
  }

  @override
  void update(double t) {
    if (world != null) {
      world.enemies.forEach((enemyId, enemy) => enemy.update(t));
      world.player.update(t);
    }
  }

  @override
  void resize(Size size) {
    this.screenSize = size;
    this.aspectRatio = AspectRatio(size);
  }

  void onWorldUpdate(World world) async {
    this.world = world;
  }

  void onDragStart(DragStartDetails details) {
    this.canMove = true;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canMove) {
      world.player.move(details);
    }
    this.canMove = false;
  }

  void onDragEnd(DragEndDetails details) {
    this.canMove = true;
  }

  void playerMoved(double x, double y) async {
    this.socketManager.send("move-player", {'x': x, 'y': y});
  }
}
