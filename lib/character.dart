import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';

abstract class Character {
  final GameController gameController;

  Rect rect;
  Paint paint;
  double xStep;
  double yStep;

  Character(this.gameController,
      {@required Size worldSize,
      @required Map<String, dynamic> json,
      @required Color color}) {
    final width = gameController.screenSize.width / worldSize.width;
    final height = gameController.screenSize.height / worldSize.height;
    rect = Rect.fromLTWH(
      json['position']['x'] * width,
      json['position']['y'] * height,
      width,
      height,
    );
    this.xStep = json['step'];
    this.yStep = json['step'];
    paint = Paint()..color = color;
  }

  void render(Canvas c) {
    c.drawRect(rect, paint);
  }

  void update(double t);
}
