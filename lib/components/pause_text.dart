import 'package:flame/components/text_component.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:grube/game/game.dart';

class PauseText {
  bool paused = false;
  List<_SleepText> _sleepTexts;

  PauseText(Game game, Size size) {
    this._sleepTexts = [
      _SleepText(
        baseSize: size,
        textSize: 12,
        xDec: -5,
        yDec: -20,
      ),
      _SleepText(
        baseSize: size,
        textSize: 10,
        xDec: 10,
        yDec: -30,
      ),
      _SleepText(
        baseSize: size,
        textSize: 8,
        xDec: 5,
        yDec: -40,
      ),
    ];

    this._sleepTexts.forEach((s) => game.add(s));
  }

  void render(Canvas c) {
    if (!paused) {
      return;
    }
    c.save();
    this._sleepTexts.forEach((s) {
      s.render(c);
      c.restore();
      c.save();
    });
  }

  void updateDimensions(Position position) {
    this._sleepTexts.forEach((s) => s.updateDimensions(position));
  }

  void pause() {
    this.paused = true;
  }

  void resume() {
    this.paused = false;
  }
}

class _SleepText extends TextComponent {
  final Size baseSize;
  final double textSize;
  final double xDec;
  final double yDec;

  _SleepText({
    @required this.baseSize,
    @required this.textSize,
    @required this.xDec,
    @required this.yDec,
  }) : super("Z",
            config: TextConfig(
              fontFamily: 'PressStart2P',
              color: Colors.black,
              fontSize: textSize,
            ));

  @override
  bool isHud() {
    return true;
  }

  void updateDimensions(Position position) {
    this.x =
        position.x * baseSize.width + (baseSize.width / 2) - (width / 2) + xDec;
    this.y = position.y * baseSize.height + yDec;
  }
}
