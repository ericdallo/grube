import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:grube/components/character.dart';
import 'package:grube/components/hurt.dart';
import 'package:grube/components/life.dart';
import 'package:grube/components/stamina.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/controller.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/audios.dart';

class Player extends Character {
  Lifes _lifes;
  Hurt _hurt;
  Stamina _stamina;

  int score;

  Player.from(GameController gameController, Map<String, dynamic> json)
      : super(
          gameController,
          json: json,
          color: Color(json['color']),
        ) {
    this._lifes = Lifes(gameController, json['life']);
    this._hurt = Hurt.screenHurt(gameController);
    this._stamina = Stamina(gameController, json['stamina']);
    this.score = json['score'];
  }

  @override
  void update(double t) {
    super.update(t);
    _hurt.update(t);
    _stamina.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _hurt.render(c);
    _lifes.render(c);
    _stamina.render(c);
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

    if (_stamina.isFull()) {
      Flame.audio.play(Audios.shoot);
      gameController.playerShot(direction, position);
      _stamina.tire();
    }
  }

  void hit() {
    super.hit();
    _lifes.hurt();
    _hurt.hurt();
    if (live) {
      Flame.audio.play(Audios.hurt);
    } else {
      Flame.audio.play(Audios.gameOver);
    }
  }

  void scorePoint(int score) {
    this.score = score;
    Flame.audio.play(Audios.score);
  }

}
