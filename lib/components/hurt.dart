import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/game/controller.dart';

const double HURT_TIME = 0.2;

class Hurt extends PositionComponent {
  final GameController gameController;
  Enemy _enemy;
  Paint _hurtPaint;

  bool _startAnimation = false;
  bool _show = false;
  double _timer = 0;

  Hurt.screenHurt(this.gameController) {
    this.x = 0;
    this.y = 0;
    this.width = gameController.screenSize.width;
    this.height = gameController.screenSize.height;

    this._hurtPaint = Paint()..color = Color(0xDDe74c3c);
    gameController.add(this);
  }

  Hurt.enemyHurt(this.gameController, Enemy enemy) {
    this._enemy = enemy;
    _updateFromEnemyPosition();

    this._hurtPaint = Paint()..color = Color(0xDDe74c3c);
    gameController.add(this);
  }

  @override
  bool isHud() {
    return true;
  }

  @override
  void render(Canvas c) {
    if (_show) {
      c.drawRect(toRect(), _hurtPaint);
    }
  }

  @override
  void update(double t) {
    if (_enemy != null) {
      _updateFromEnemyPosition();
    }

    if (!_startAnimation) {
      return;
    }

    _show = true;
    _timer += t;

    if (_timer >= HURT_TIME) {
      _resetHurt();
    }
  }

  void _resetHurt() {
    _timer = 0;
    _startAnimation = false;
    _show = false;
  }

  void hurt() {
    this._startAnimation = true;
  }

  void _updateFromEnemyPosition() {
    this.x = _enemy.position.x * _enemy.size.width;
    this.y = _enemy.position.y * _enemy.size.height;
    this.width = _enemy.size.width;
    this.height = _enemy.size.height;
  }
}
