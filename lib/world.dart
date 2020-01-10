import 'package:flutter/cupertino.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/player.dart';
import 'package:grube/enemy.dart';

class World {
  Size size;
  Player player;
  List<Enemy> enemies;

  World.from(
    GameController gameController,
    String playerId,
    Map<String, dynamic> json,
  ) {
    this.size = Size(json['size']['width'], json['size']['height']);
    var player =
        json['players'].singleWhere((player) => player['id'] == playerId);
    this.player = Player.from(gameController, size, player);
    this.enemies = List.of(
            json['players']..removeWhere((player) => player['id'] == playerId))
          .map((enemy) => Enemy.from(gameController, size, enemy))
          .toList();
  }
}
