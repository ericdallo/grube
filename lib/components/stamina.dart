import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:grube/game/controller.dart';

const double WIDTH = 92;
const double HEIGHT = 12;
const double MARGIN = 8;
const double Y = 44;

class Stamina extends PositionComponent {
  final GameController gameController;
  _ChargingStamina _chargingStamina;
  Paint _paint;

  Stamina(this.gameController, int stamina) {
    this.renderFlipX = true;
    this.x = gameController.screenSize.width - WIDTH - MARGIN;
    this.y = Y;
    this.width = WIDTH;
    this.height = HEIGHT;
    this._paint = Paint()..color = Color(0xFF3498db);
    this._chargingStamina = _ChargingStamina(gameController, stamina);

    gameController.add(this);
  }

  @override
  void render(Canvas c) {
    c.drawRect(toRect(), _paint);
    _chargingStamina.render(c);
  }

  @override
  void update(double t) {
    _chargingStamina.update(t);
  }

  @override
  bool isHud() {
    return true;
  }

  bool isFull() {
    return !_chargingStamina.charging;
  }

  void tire() {
    this._chargingStamina.tire();
  }
}

const CHARGING_WIDTH = WIDTH - 4;
const CHARGING_HEIGHT = HEIGHT - 4;

class _ChargingStamina extends PositionComponent {
  final GameController gameController;

  Paint _chargingPaint;
  bool charging = false;
  int _refuelTime;
  double _timer = 0;

  _ChargingStamina(this.gameController, int stamina) {
    this.renderFlipX = true;
    this._chargingPaint = Paint()..color = Color(0xFFFFFFFF);
    this.x = gameController.screenSize.width - WIDTH - MARGIN + 2;
    this.y = Y + 2;
    this.width = 0;
    this.height = CHARGING_HEIGHT;
    this._refuelTime = stamina * 100;

    gameController.add(this);
  }

  @override
  void render(Canvas c) {
    c.drawRect(toRect(), _chargingPaint);
  }

  @override
  void update(double t) {
    if (!charging) {
      return;
    }

    _timer += t * 1000;
    width -= t * 100;

    if (_timer >= _refuelTime) {
      charging = false;
      _timer = 0;
      width = 0;
    }
  }

  void tire() {
    width = CHARGING_WIDTH;
    charging = true;
  }
}
