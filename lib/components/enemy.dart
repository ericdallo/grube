import 'dart:ui';

import 'package:grube/components/animation/die.dart';
import 'package:grube/components/animation/hurt.dart';
import 'package:grube/components/character.dart';
import 'package:grube/components/score_text.dart';
import 'package:grube/components/pause_text.dart';
import 'package:grube/game/game.dart';

class Enemy extends Character {
  HurtAnimation _hurtAnimation;
  DieAnimation _dieAnimation;
  ScoreText _scoreText;
  PauseText _pauseText;

  Enemy.from(
    Game game,
    Map<String, dynamic> json,
  ) : super(
          game,
          json: json,
          color: Color(0xFF999999),
        ) {
    this._hurtAnimation = HurtAnimation(game);
    this._dieAnimation = DieAnimation(game, this);
    this._scoreText = ScoreText(game, this.score, this.size);
    this._pauseText = PauseText(game, this.size);
  }

  @override
  void update(double t) {
    super.update(t);
    _dieAnimation.updateDimensions(position, size);
    _hurtAnimation.updateDimensions(position, size);
    _scoreText.updateDimensions(position);
    _pauseText.updateDimensions(position);

    _scoreText.updateScore(score);

    _hurtAnimation.update(t);
    _dieAnimation.update(t);
    _scoreText.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _hurtAnimation.render(c);
    _dieAnimation.render(c);
    if (live) {
      _scoreText.render(c);
      _pauseText.render(c);
    }
  }

  void hit() {
    super.hit();

    if (live) {
      _hurtAnimation.play();
    } else {
      _dieAnimation.play();
    }
  }

  void pause() => _pauseText.pause();

  void resume() => _pauseText.resume();
}
