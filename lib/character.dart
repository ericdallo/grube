import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/bullet.dart';
import 'package:grube/direction.dart';
import 'package:grube/enums.dart';
import 'package:grube/game_controller.dart';

abstract class Character {
  final GameController gameController;
  List<Bullet> bullets;

  Size size;
  Position position;
  Direction direction;

  Rect rect;
  Paint paint;
  double xStep;
  double yStep;

  Character(this.gameController,
      {@required Size worldSize,
      @required Map<String, dynamic> json,
      @required Color color}) {
    this.bullets = json['bullets']
        .map((bullet) => Bullet.from(gameController, worldSize, bullet))
        .toList()
        .cast<Bullet>();
    this.position = Position(json['position']['x'], json['position']['y']);
    this.direction = Enums.fromString(Direction.values, json['direction']);

    final width = gameController.screenSize.width / worldSize.width;
    final height = gameController.screenSize.height / worldSize.height;

    this.size = Size(width, height);
    this.xStep = json['step'] * width;
    this.yStep = json['step'] * height;
    this.paint = Paint()..color = color;
    _buildShape();
  }

  void _buildShape() {
    rect = Rect.fromLTWH(
      position.x * size.width,
      position.y * size.height,
      size.width,
      size.height,
    );
  }

  void update(double t) {
    _buildShape();
  }

  void render(Canvas c) {
    c.drawRect(rect, paint);
    this.bullets.forEach((bullet) => bullet.render(c));
  }
}
