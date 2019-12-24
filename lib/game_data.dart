import 'package:grube/game_controller.dart';
import 'package:grube/player.dart';
import 'package:grube/enemy.dart';

class GameData {
  Player player;
  Map<String, Enemy> enemies;

  GameData.from(GameController gameController, Map<String, dynamic> json) {
    this.player = Player.from(gameController, json['player']);
    this.enemies = json['enemies'].map((enemyId, enemy) =>
        MapEntry(enemyId, Enemy.from(gameController, enemy))).cast<String, Enemy>();
  }
}
