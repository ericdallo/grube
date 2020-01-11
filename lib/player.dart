import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/direction.dart';
import 'package:grube/character.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/life.dart';

class Player extends Character {
  Lifes _lifes;

  Player.from(
      GameController gameController, Size worldSize, Map<String, dynamic> json)
      : _lifes = Lifes(gameController, json['life']),
        super(
          gameController,
          worldSize: worldSize,
          json: json,
          color: Color(json['color']),
        );

  @override
  void render(Canvas c) {
    super.render(c);
    _lifes.render(c);
  }

  void move(Direction direction) {
    if (!live) {
      return;
    }

    bool teleportRight = position.x + 1 >= gameController.world.size.width;
    bool teleportLeft = position.x <= 0;
    bool teleportDown = position.y + 1 >= gameController.world.size.height;
    bool teleportUp = position.y <= 0;

    if (direction == Direction.right) {
      position.x = teleportRight ? 0 : position.x + 1;
    }

    if (direction == Direction.left) {
      position.x =
          teleportLeft ? gameController.world.size.width - 1 : position.x - 1;
    }

    if (direction == Direction.down) {
      position.y = teleportDown ? 0 : position.y + 1;
    }

    if (direction == Direction.up) {
      position.y =
          teleportUp ? gameController.world.size.height - 1 : position.y - 1;
    }

    this.direction = direction;
    gameController.playerMoved(direction, position);
  }

  void shoot() {
    if (!live) {
      return;
    }

    double x, y;
    if (direction == Direction.right) {
      x = position.x + 1;
      y = position.y;
    }

    if (direction == Direction.left) {
      x = position.x - 1;
      y = position.y;
    }

    if (direction == Direction.down) {
      x = position.x;
      y = position.y + 1;
    }

    if (direction == Direction.up) {
      x = position.x;
      y = position.y - 1;
    }

    gameController.playerShot(direction, Position(x, y));
  }
}
