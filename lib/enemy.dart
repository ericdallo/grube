import 'dart:ui';

import 'package:grube/game_controller.dart';
import 'package:grube/character.dart';

class Enemy extends Character {

  Enemy.from(GameController gameController, Map<String, dynamic> json)
      : super(
          gameController,
          json: json,
          color: Color(0xFF999999),
        );

  @override
  void update(double t) {}
}
