import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/components/player.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';

class World {
  World._();

  static World _instance;

  static World get instance {
    return _instance ??= World._();
  }

  Size size;
  Player player;
  List<Enemy> enemies = [];

  void load(Game game, player, world) {
    this.size = Size(world['size']['width'], world['size']['height']);
    this.player = Player.from(game, player);
    this.enemies =
        List.of(world['players']..removeWhere((p) => p['id'] == player['id']))
            .map((enemy) => Enemy.from(game, enemy))
            .toList();
  }

  void addEnemy(Enemy enemy) {
    this.enemies.add(enemy);
  }

  void removeEnemy(String enemyId) {
    this.enemies.removeWhere((e) => e.id == enemyId);
  }

  void moveEnemy(String enemyId, Position position, Direction direction) {
    this.enemies.where((enemy) => enemy.id == enemyId).forEach((enemy) {
      enemy.position = position;
      enemy.direction = direction;
    });
  }

  void moveBullets(Map<String, dynamic> bulletsByPlayer) {
    bulletsByPlayer.forEach((playerId, bullets) {
      if (playerId == player.id) {
        player.moveBullets(bullets);
        return;
      }
      this
          .enemies
          .where((enemy) => enemy.id == playerId)
          .forEach((enemy) => enemy.moveBullets(bullets));
    });
  }

  void hitPlayers(List<String> playerIds) {
    playerIds.forEach((playerId) {
      if (playerId == player.id) {
        player.hit();
        return;
      }
      this
          .enemies
          .where((enemy) => enemy.id == playerId)
          .forEach((enemy) => enemy.hit());
    });
  }
}
