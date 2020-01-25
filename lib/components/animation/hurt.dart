import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/game/game.dart';

const double HURT_TIME = 0.2;

class HurtAnimation extends PositionComponent {
  final Game game;
  Paint _hurtPaint;

  bool _startAnimation = false;
  double _timer = 0;

  HurtAnimation(this.game) {
    this.x = 0;
    this.y = 0;
    this.width = game.screenSize.width;
    this.height = game.screenSize.height;

    this._hurtPaint = Paint()..color = Color(0xDDe74c3c);
    game.add(this);
  }

  @override
  bool isHud() {
    return true;
  }

  @override
  void render(Canvas c) {
    if (_startAnimation) {
      c.drawRect(toRect(), _hurtPaint);
    }
  }

  @override
  void update(double t) {
    if (!_startAnimation) {
      return;
    }

    _timer += t;

    if (_timer >= HURT_TIME) {
      _resetHurt();
    }
  }

  void _resetHurt() {
    _timer = 0;
    _startAnimation = false;
  }

  void play() {
    this._startAnimation = true;
  }

  void updateDimensions(Position position, Size size) {
    this.x = position.x * size.width;
    this.y = position.y * size.height;
    this.width = size.width;
    this.height = size.height;
  }
}
