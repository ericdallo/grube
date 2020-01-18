import 'dart:ui';

import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/palette.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

TextConfig regular = TextConfig(
  fontFamily: 'PressStart2P',
  color: BasicPalette.black.color,
  fontSize: 40,
);

class GameOverText extends TextComponent {

  GameOverText(Size size)
      : super(
          'GAME OVER',
          config: regular,
        ) {
    x = (size.width / 2) - (width / 2);
    y = (size.height / 2) - height;
  }

  @override
  bool isHud() {
    return true;
  }

  @override
  void render(Canvas c) {
    c.save();
    super.render(c);
    c.restore();
  }
}
