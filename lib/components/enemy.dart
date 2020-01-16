import 'dart:ui';

import 'package:grube/components/character.dart';
import 'package:grube/game/controller.dart';

class Enemy extends Character {

  Enemy.from(
    GameController gameController,
    Map<String, dynamic> json,
  ) : super(
          gameController,
          json: json,
          color: Color(0xFF999999),
        );
}
