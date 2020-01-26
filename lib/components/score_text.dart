import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/palette.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';

final TextConfig regularText = TextConfig(
  fontFamily: 'PressStart2P',
  color: BasicPalette.black.color,
  fontSize: 18,
);

class ScoreText extends TextComponent {
  Size size;

  ScoreText(int score, this.size)
      : super(
          score.toString(),
          config: regularText,
        );

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

  void updateDimensions(Position position) {
    this.x = position.x * size.width + (size.width / 2) - (width / 2);
    this.y = position.y * size.height + (size.height / 2) - (height / 2);
  }
}
