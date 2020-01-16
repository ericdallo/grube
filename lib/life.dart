import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:grube/game_controller.dart';

const double _SIZE = 36;

class Lifes {
  final GameController gameController;
  final List<Life> lifes = [];

  Lifes(this.gameController, int lifes) {
    for (var i = 1; i <= lifes; i++) {
      var life = Life(i * _SIZE);

      this.lifes.add(life);
      this.gameController.add(life);
    }
  }

  void render(Canvas c) {
    c.save();
    this.lifes.forEach((life) {
      life.render(c);
      c.restore();
      c.save();
    });
  }

  void hurt() {
    this.lifes.lastWhere((life) => !life.hurted).hurt();
  }
}

class Life extends SpriteComponent {
  double xDec;
  bool hurted = false;

  Life(this.xDec) : super.square(_SIZE, 'full_life.png');

  @override
  void resize(Size size) {
    this.x = size.width - xDec;
    this.y = 0;
  }

  @override
  bool isHud() {
    return true;
  }

  void hurt() {
    this.hurted = true;
    this.sprite = Sprite('empty_life.png');
  }
}
