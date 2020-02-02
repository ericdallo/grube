import 'dart:ui';

import 'package:flame/position.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/socket/event/data.dart';

const double SMALL_SIZE = 8;
const double BIG_SIZE = 16;

class Bullet {
  Direction direction;
  Position position;

  Paint _paint;
  Rect _rect;

  Bullet.from(
    Game game,
    double playerWidth,
    double playerHeight,
    Color color,
    BulletData data,
  ) {
    this.direction = data.direction;
    this.position = Position(data.position.x, data.position.y);

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

    _rect = Rect.fromLTWH(
      position.x * playerWidth + centerX,
      position.y * playerHeight + centerY,
      width,
      height,
    );
  }

  void render(Canvas c) {
    c.drawRect(_rect, _paint);
  }
}
