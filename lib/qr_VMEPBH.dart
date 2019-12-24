import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';

class Player {
  final GameController gameController;
  final double maxSpeed = 2;

  Size size;
  Rect playerRect;
  Paint paint;
  double speed;
  bool moving = false;

  double dx = 0;
  double dy = 0;

  Player(this.gameController) {
    final size = gameController.tileSize * 1.5;
    playerRect = Rect.fromLTWH(
      gameController.screenSize.width / 2 - (size / 2),
      gameController.screenSize.height / 2 - (size / 2),
      size,
      size,
    );
    paint = Paint()..color = Color(0xFF1ABC9C);
    speed = gameController.tileSize * 2;
  }

  void render(Canvas c) {
    c.drawRect(playerRect, paint);
  }

  void update(double t) {
    double x = speed * t * min(dx, maxSpeed);
    double y = speed * t * min(dy, maxSpeed);
    playerRect = playerRect.translate(x, y);
  }

  void move(DragUpdateDetails details) {
    dx = min(details.delta.dx, maxSpeed);
    dy = min(details.delta.dy, maxSpeed);
  }
}
