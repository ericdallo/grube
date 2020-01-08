import 'dart:ui';

import 'package:flame/position.dart';
import 'package:grube/direction.dart';
import 'package:grube/enums.dart';
import 'package:grube/game_controller.dart';

class Bullet {
  Direction direction;
  Position position;

  Paint _paint;
  double _radius;
  Offset _offset;

  Bullet.from(GameController gameController, Size worldSize, Color color, Map<String, dynamic> json) {
    this.direction = Enums.fromString(Direction.values, json['direction']);
    this.position = Position(json['position']['x'], json['position']['y']);

    this._paint = Paint()..color = color;
    this._radius = 8.0;
    final width = gameController.screenSize.width / worldSize.width;
    final height = gameController.screenSize.height / worldSize.height;
    final centerPositionX = width / 2;
    final centerPositionY = height / 2;

    this._offset = Offset(position.x * width + centerPositionX, position.y * height + centerPositionY);
  }

  void render(Canvas c) {
    c.drawCircle(_offset, _radius, _paint);
  }
}
