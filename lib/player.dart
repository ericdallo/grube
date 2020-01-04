import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/character.dart';

class Player extends Character {

  Player.from(GameController gameController, Size worldSize, Map<String, dynamic> json)
      : super(
          gameController,
          worldSize: worldSize,
          json: json,
          color: Color(json['color']),
        );

  @override
  void update(double t) {}

  void move(DragUpdateDetails details) {
    var dx = details.delta.dx;
    var dy = details.delta.dy;

    bool canMoveRight = rect.right + xStep <= gameController.screenSize.width + 1;
    bool canMoveLeft = rect.left - xStep >= -1;
    bool canMoveDown = rect.bottom + yStep <= gameController.screenSize.height + 1;
    bool canMoveUp = rect.top - yStep >= -1;

    if (dx > 0 && canMoveRight) {
      rect = rect.translate(xStep, 0);
    }

    if (dx < 0 && canMoveLeft) {
      rect = rect.translate(-xStep, 0);
    }

    if (dy > 0 && canMoveDown) {
      rect = rect.translate(0, yStep);
    }

    if (dy < 0 && canMoveUp) {
      rect = rect.translate(0, -yStep);
    }
    gameController.playerMoved(rect.left / rect.size.width, rect.top / rect.size.height);
  }
}
