import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:grube/game_controller.dart';

const double _SIZE = 36;
const int MAX_LIFES = 3;

class Lifes {
  final GameController gameController;
  final List<Life> lifes = [];

  Lifes(this.gameController, int lifes) {
    for (var i = 1; i <= MAX_LIFES; i++) {
      String spriteName = lifes >= i ? 'full_life' : 'empty_life';

      var life = Life(i * _SIZE, spriteName);

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
}

class Life extends SpriteComponent {
  double xDec;

  Life(this.xDec, sprite) : super.square(_SIZE, sprite + '.png');

  @override
  void resize(Size size) {
    this.x = size.width - xDec;
    this.y = 0;
  }

  @override
  bool isHud() {
    return true;
  }
}
