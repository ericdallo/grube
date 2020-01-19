import 'dart:ui';

import 'package:flame/position.dart';
import 'package:grube/direction.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/game/game.dart';

const double SMALL_SIZE = 8;
const double BIG_SIZE = 16;

class Bullet {
  Direction direction;
  Position position;

  Paint _paint;
  RRect _rrect;

  Bullet.from(
    Game game,
    double playerWidth,
    double playerHeight,
    Color color,
    Map<String, dynamic> json,
  ) {
    this.direction = Enums.fromString(Direction.values, json['direction']);
    this.position = Position(json['position']['x'], json['position']['y']);

    this._paint = Paint()..color = color;

    double width, height, centerX, centerY;
    if (direction == Direction.right || direction == Direction.left) {
      width = BIG_SIZE;
      height = SMALL_SIZE;
      centerX = playerWidth / 2 - (BIG_SIZE / 2);
      centerY = playerHeight / 2 - (SMALL_SIZE / 2);
    } else {
      width = SMALL_SIZE;
      height = BIG_SIZE;
      centerX = playerWidth / 2 - (SMALL_SIZE / 2);
      centerY = playerHeight / 2 - (BIG_SIZE / 2);
    }

    Rect rect = Rect.fromLTWH(
      position.x * playerWidth + centerX,
      position.y * playerHeight + centerY,
      width,
      height,
    );
    _rrect = RRect.fromRectXY(rect, 2, 2);
  }

  void render(Canvas c) {
    c.drawRRect(_rrect, _paint);
  }
}
