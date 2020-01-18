import 'package:flame/flame.dart';

class Audios {
  static String hurt = 'player_hurt.mp3';
  static String gameOver = 'game_over.mp3';
  static String shoot = 'shoot.mp3';
  static String score = 'score.mp3';

  Audios._();

  static Audios _instance;

  static Audios get instance {
    return _instance ??= Audios._();
  }

  void loadAll() async {
    await Flame.audio.loadAll([hurt, gameOver, score, shoot]);
  }

}
