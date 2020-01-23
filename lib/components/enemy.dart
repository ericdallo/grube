import 'dart:ui';

import 'package:grube/components/character.dart';
import 'package:grube/game/game.dart';
import 'package:grube/components/hurt.dart';

class Enemy extends Character {
  Hurt _hurt;

  Enemy.from(
    Game game,
    Map<String, dynamic> json,
  ) : super(
          game,
          json: json,
          color: Color(0xFF999999),
        ) {
    this._hurt = Hurt.enemyHurt(game, this);
  }

  @override
  void update(double t) {
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
