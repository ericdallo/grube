import 'dart:ui';

import 'package:grube/game_controller.dart';
import 'package:grube/character.dart';

class Enemy extends Character {
  Enemy.from(
      GameController gameController, Size worldSize, Map<String, dynamic> json)
      : super(
          gameController,
          worldSize: worldSize,
          json: json,
          color: Color(0xFF999999),
        );
}
