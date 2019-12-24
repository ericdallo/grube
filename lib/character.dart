import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';

abstract class Character {
  final GameController gameController;
  final double maxSpeed = 3;

  Rect rect;
  Paint paint;
  double speed;

  Character(this.gameController, {@required Map<String, dynamic> json, @required Color color}) {
    this.speed = gameController.tileSize * json['speed'];
    final size = gameController.tileSize * json['size'];
    rect = Rect.fromLTWH(
      json['position']['x'],
      json['position']['y'],
      size,
      size,
    );
    paint = Paint()..color = color;
  }

  void render(Canvas c) {
    c.drawRect(rect, paint);
  }

  void update(double t);
}
