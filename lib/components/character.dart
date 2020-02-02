import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/components/bullet.dart';
import 'package:grube/components/crown.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/socket/event/data.dart';

abstract class Character extends PositionComponent {
  final Game game;
  List<Bullet> bullets;
  Crown _crown;

  String id;
  Size size;
  Position position;
  Direction direction;
  int life;
  int score;

  Paint paint;
  double xStep;
  double yStep;

  bool get live => life > 0;

  Character(
    this.game, {
    @required CharacterData data,
    @required Color color,
  }) {
    final width = game.screenSize.width / World.instance.size.width;
    final height = game.screenSize.height / World.instance.size.height;

    this.id = data.id;
    this.bullets = data.bullets
        .map((bullet) => Bullet.from(game, width, height, color, bullet))
        .toList()
        .cast<Bullet>();
    this.position = Position(data.position.x, data.position.y);
    this.direction = data.direction;
    this.life = data.life;
    this.score = data.score;

    this.size = Size(width, height);
    this.xStep = data.step * width;
    this.yStep = data.step * height;
    this.paint = Paint()..color = color;

    this.width = size.width;
    this.height = size.height;
    _updatePosition();

    this._crown = Crown(this.position, this.size);
    game.add(_crown);
  }

  void _updatePosition() {
    this.x = position.x * size.width;
    this.y = position.y * size.height;
  }

  @override
  void update(double t) {
    _updatePosition();
    _crown.updateDimensions(position, size);
    _crown.update(t);
  }

  @override
  void render(Canvas c) {
    if (live) {
      c.drawRect(toRect(), paint);
    }

    this.bullets.forEach((bullet) => bullet.render(c));

    _crown.render(c);
  }

  void moveBullets(List<BulletData> bullets) {
    this.bullets = bullets
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

  void crown() {
    this._crown.show = true;
  }

  void uncrown() {
    this._crown.show = false;
  }
}
