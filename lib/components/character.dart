import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/components/bullet.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/enums.dart';

abstract class Character extends PositionComponent {
  final Game game;
  List<Bullet> bullets;

  String id;
  Size size;
  Position position;
  Direction direction;
  int life;

  Paint paint;
  double xStep;
  double yStep;

  bool get live => life > 0;

  Character(
    this.game, {
    @required Map<String, dynamic> json,
    @required Color color,
  }) {
    final width = game.screenSize.width / World.instance.size.width;
    final height = game.screenSize.height / World.instance.size.height;

    this.id = json['id'];
    this.bullets = json['bullets']
        .map((bullet) => Bullet.from(game, width, height, color, bullet))
        .toList()
        .cast<Bullet>();
    this.position = Position(json['position']['x'], json['position']['y']);
    this.direction = Enums.fromString(Direction.values, json['direction']);
    this.life = json['life'];

    this.size = Size(width, height);
    this.xStep = json['step'] * width;
    this.yStep = json['step'] * height;
    this.paint = Paint()..color = color;

    this.x = position.x * size.width;
    this.y = position.y * size.height;
    this.width = size.width;
    this.height = size.height;
  }

  @override
  void render(Canvas c) {
    if (live) {
      c.drawRect(toRect(), paint);
    }

    this.bullets.forEach((bullet) => bullet.render(c));
  }

  void moveBullets(List<dynamic> bulletsJson) {
    this.bullets = bulletsJson
        .map((bullet) => Bullet.from(
              game,
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
