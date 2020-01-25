import 'dart:ui';

import 'package:grube/components/character.dart';
import 'package:grube/game/game.dart';
import 'package:grube/components/animation/hurt.dart';
import 'package:grube/components/animation/die.dart';

class Enemy extends Character {
  HurtAnimation _hurtAnimation;
  DieAnimation _dieAnimation;

  Enemy.from(
    Game game,
    Map<String, dynamic> json,
  ) : super(
          game,
          json: json,
          color: Color(0xFF999999),
        ) {
    this._hurtAnimation = HurtAnimation(game);
    this._dieAnimation = DieAnimation(game, this);
  }

  @override
  void update(double t) {
    super.update(t);
    _dieAnimation.updateDimensions(position, size);
    _hurtAnimation.updateDimensions(position, size);
    _hurtAnimation.update(t);
    _dieAnimation.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _hurtAnimation.render(c);
    _dieAnimation.render(c);
  }

  void hit() {
    super.hit();

    if (live) {
      _hurtAnimation.play();
    } else {
      _dieAnimation.play();
    }
  }
}
