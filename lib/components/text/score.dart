import 'dart:ui';

import 'package:flame/components/text_box_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/palette.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

TextConfig regular = TextConfig(
  fontFamily: 'PressStart2P',
  color: BasicPalette.black.color,
  fontSize: 36,
  textAlign: TextAlign.left,
);

class ScoreText extends TextComponent {
  ScoreText(Size size)
      : super(
          '0',
          config: regular,
        ) {
    x = 8;
    y = 8;
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

  void updateScore(int score) {
    this.text = score.toString();
  }
}
