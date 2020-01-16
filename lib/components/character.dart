import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/components/bullet.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/controller.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/enums.dart';

abstract class Character {
  final GameController gameController;
  List<Bullet> bullets;

  String id;
  Size size;
  Position position;
  Direction direction;
  int life;

  Rect rect;
  Paint paint;
  double xStep;
  double yStep;

  bool get live => life > 0;

  Character(this.gameController,
      {@required Map<String, dynamic> json, @required Color color}) {
    final width = gameController.screenSize.width / World.instance.size.width;
    final height =
        gameController.screenSize.height / World.instance.size.height;

    this.id = json['id'];
    this.bullets = json['bullets']
        .map((bullet) =>
            Bullet.from(gameController, width, height, color, bullet))
        .toList()
        .cast<Bullet>();
    this.position = Position(json['position']['x'], json['position']['y']);
    this.direction = Enums.fromString(Direction.values, json['direction']);
    this.life = json['life'];

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
    if (live) {
      _buildShape();
    }
  }

  void render(Canvas c) {
    if (live) {
      c.drawRect(rect, paint);
    }

    this.bullets.forEach((bullet) => bullet.render(c));
  }

  void moveBullets(List<dynamic> bulletsJson) {
    this.bullets = bulletsJson
        .map((bullet) => Bullet.from(
              gameController,
              size.width,
              size.height,
              paint.color,
              bullet,
            ))
        .toList();
  }

  void hit() {
    life--;
  }
}
