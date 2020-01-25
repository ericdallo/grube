import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:grube/components/character.dart';
import 'package:grube/game/game.dart';

const double DIE_TIME = 1;

class DieAnimation extends PositionComponent {
  final Game game;
  Size _size;
  Position _position;

  double _reduceWidth;
  double _reduceHeight;

  Paint _paint;

  bool _startAnimation = false;
  double _timer = 0;

  DieAnimation(this.game, Character character) {
    updateDimensions(character.position, character.size);
    this._reduceWidth = round(_size.width / 5);
    this._reduceHeight = round(_size.height / 5);

    this._paint = Paint()..color = Color(0xDDe74c3c);
    game.add(this);
  }

  @override
  bool isHud() {
    return true;
  }

  @override
  void render(Canvas c) {
    if (_startAnimation) {
      c.drawRect(toRect(), _paint);
    }
  }

  @override
  void update(double t) {
    if (!_startAnimation) {
      this.x = _position.x * _size.width;
      this.y = _position.y * _size.height;
      this.width = _size.width;
      this.height = _size.height;
      return;
    }

    _timer += t;

    if (_timer >= DIE_TIME) {
      _reset();
      return;
    }

    if (_timer < DIE_TIME / 5 && canReduce(1)) {
      _reduce();
      return;
    }

    if (_timer >= DIE_TIME / 5 && _timer < DIE_TIME / 4 && canReduce(2)) {
      _reduce();
      return;
    }

    if (_timer >= DIE_TIME / 4 && _timer < DIE_TIME / 3 && canReduce(3)) {
      _reduce();
      return;
    }

    if (_timer >= DIE_TIME / 3 && _timer < DIE_TIME / 2 && canReduce(4)) {
      _reduce();
      return;
    }

    if (_timer >= DIE_TIME / 2 && canReduce(5)) {
      _reduce();
      return;
    }
  }

  void _reset() {
    _timer = 0;
    _startAnimation = false;
  }

  void play() {
    this._startAnimation = true;
  }

  void updateDimensions(Position position, Size size) {
    this._position = position;
    this._size = size;
  }

  bool canReduce(int size) {
    var reduceWidthSize = _reduceWidth * size;
    var reduceHeightSize = _reduceHeight * size;

    return round(this._size.width - reduceWidthSize) != round(this.width) &&
        round(this._size.height - reduceHeightSize) != round(this.height);
  }

  void _reduce() {
    this.x += _reduceWidth / 2;
    this.y += _reduceHeight / 2;
    this.width -= _reduceWidth;
    this.height -= _reduceHeight;
  }

  double round(double n) {
    return num.parse(n.toStringAsFixed(4));
  }
}
