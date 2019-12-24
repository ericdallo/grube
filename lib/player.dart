import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/character.dart';

class Player extends Character {
  double dx = 0;
  double dy = 0;

  Player.from(GameController gameController, Map<String, dynamic> json)
      : super(
          gameController,
          json: json,
          color: Color(json['color']),
        );

  @override
  void update(double t) {
    double x = speed * t * dx;
    double y = speed * t * dy;

    if (rect.left + x <= 0) {
      x = -rect.left;
    }

    if (rect.right + x >= gameController.screenSize.width) {
      x = gameController.screenSize.width - rect.right;
    }

    if (rect.top + y <= 0) {
      y = -rect.top;
    }

    if (rect.bottom + y >= gameController.screenSize.height) {
      y = gameController.screenSize.height - rect.bottom;
    }

    rect = rect.translate(x, y);
  }

  void move(DragUpdateDetails details) {
    if (details.delta.dx >= 0) {
      dx = min(details.delta.dx, maxSpeed);
    } else {
      dx = max(details.delta.dx, -maxSpeed);
    }

    if (details.delta.dy >= 0) {
      dy = min(details.delta.dy, maxSpeed);
    } else {
      dy = max(details.delta.dy, -maxSpeed);
    }
  }
}
