import 'dart:ui';

import 'package:grube/components/character.dart';
import 'package:grube/game/controller.dart';
import 'package:grube/components/hurt.dart';

class Enemy extends Character {
  Hurt _hurt;

  Enemy.from(
    GameController gameController,
    Map<String, dynamic> json,
  ) : super(
          gameController,
          json: json,
          color: Color(0xFF999999),
        ) {
    this._hurt = Hurt.enemyHurt(gameController, this);
  }

  @override
  void update(double t) {
    super.update(t);
    _hurt.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _hurt.render(c);
  }

  void hit() {
    super.hit();
    _hurt.hurt();
  }
}
