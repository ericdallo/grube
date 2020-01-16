import 'dart:ui';

import 'package:flame/position.dart';
import 'package:grube/direction.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/game/controller.dart';

class Bullet {
  Direction direction;
  Position position;

  Paint _paint;
  double _radius;
  Offset _offset;

  Bullet.from(
    GameController gameController,
    double width,
    double height,
    Color color,
    Map<String, dynamic> json,
  ) {
    this.direction = Enums.fromString(Direction.values, json['direction']);
    this.position = Position(json['position']['x'], json['position']['y']);

    this._paint = Paint()..color = color;
    this._radius = 8.0;
    final centerPositionX = width / 2;
    final centerPositionY = height / 2;

    this._offset = Offset(
      position.x * width + centerPositionX,
      position.y * height + centerPositionY,
    );
  }

  void render(Canvas c) {
    c.drawCircle(_offset, _radius, _paint);
  }
}
