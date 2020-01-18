import 'package:flutter/cupertino.dart';
import 'package:grube/components/character.dart';
import 'package:grube/components/hurt.dart';
import 'package:grube/components/life.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/controller.dart';
import 'package:grube/game/world.dart';

class Player extends Character {
  Lifes _lifes;
  Hurt _hurt;

  int score;

  Player.from(GameController gameController, Map<String, dynamic> json)
      : super(
          gameController,
          json: json,
          color: Color(json['color']),
        ) {
    this._lifes = Lifes(gameController, json['life']);
    this.score = json['score'];
    this._hurt = Hurt(gameController);
  }

  @override
  void update(double t) {
    super.update(t);
    _hurt.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _lifes.render(c);
    _hurt.render(c);
  }

  void move(Direction direction) {
    if (!live) {
      return;
    }

    var world = World.instance;

    bool teleportRight = position.x + 1 >= world.size.width;
    bool teleportLeft = position.x <= 0;
    bool teleportDown = position.y + 1 >= world.size.height;
    bool teleportUp = position.y <= 0;

    if (direction == Direction.right) {
      position.x = teleportRight ? 0 : position.x + 1;
    }

    if (direction == Direction.left) {
      position.x = teleportLeft ? world.size.width - 1 : position.x - 1;
    }

    if (direction == Direction.down) {
      position.y = teleportDown ? 0 : position.y + 1;
    }

    if (direction == Direction.up) {
      position.y = teleportUp ? world.size.height - 1 : position.y - 1;
    }

    this.direction = direction;
    gameController.playerMoved(direction, position);
  }

  void shoot() {
    if (!live) {
      return;
    }

    gameController.playerShot(direction, position);
  }

  void hit() {
    super.hit();
    _lifes.hurt();
    _hurt.hurt();
  }

  void updateScore(int score) {
    this.score = score;
    gameController.scoreUpdated(score);
  }
}
