import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/player.dart';
import 'package:grube/enemy.dart';

class World {
  Size size;
  Player player;
  Map<String, Enemy> enemies;

  World.from(
    GameController gameController,
    String playerId,
    Map<String, dynamic> json,
  ) {
    this.size = Size(json['size']['width'], json['size']['height']);
    this.player = Player.from(gameController, size, json['players'][playerId]);
    var enemies = Map.from(json['players'])
      ..removeWhere((k, v) => k == playerId);
    this.enemies = enemies
        .map((enemyId, enemy) =>
            MapEntry(enemyId, Enemy.from(gameController, size, enemy)))
        .cast<String, Enemy>();
  }
}
