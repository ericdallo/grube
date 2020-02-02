import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/components/player.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/socket/event/data.dart';

class World {
  World._();

  static World _instance;

  static World get instance {
    return _instance ??= World._();
  }

  Size size;
  Player player;
  List<Enemy> enemies = [];

  void load(Game game, CharacterData player, WorldData world) {
    this.size = Size(world.size.width, world.size.height);
    this.player = Player.from(game, player);
    this.enemies = List.of(world.players..removeWhere((p) => p.id == player.id))
        .map((enemy) => Enemy.from(game, enemy))
        .toList();
  }

  void unload() {
    this.size = null;
    this.player = null;
    this.enemies = [];
  }

  void addEnemy(Enemy enemy) {
    this.enemies.add(enemy);
  }

  void removeEnemy(String enemyId) {
    this.enemies.removeWhere((e) => e.id == enemyId);
  }

  void pauseEnemy(String enemyId) {
    this.enemies.where((e) => e.id == enemyId).forEach((e) => e.pause());
  }

  void resumeEnemy(String enemyId) {
    this.enemies.where((e) => e.id == enemyId).forEach((e) => e.resume());
  }

  void moveEnemy(String enemyId, Position position, Direction direction) {
    this.enemies.where((enemy) => enemy.id == enemyId).forEach((enemy) {
      enemy.position = position;
      enemy.direction = direction;
    });
  }

  void playerShot(List<dynamic> bullets) {
    player.moveBullets(bullets);
  }

  void enemyShot(String enemyId, List<dynamic> bullets) {
    this
        .enemies
        .where((enemy) => enemy.id == enemyId)
        .forEach((enemy) => enemy.moveBullets(bullets));
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

  void enemiesScored(enemies) {
    enemies.forEach((enemyScored) {
      Enemy enemy =
          this.enemies.singleWhere((enemy) => enemy.id == enemyScored['id']);

      enemy.score = enemyScored['score'];
    });
  }

  void updateCrownedPlayer(String playerId) {
    if (playerId == player.id) {
      this.player.crown();
      this.enemies.forEach((enemy) => enemy.uncrown());
      return;
    }

    this.player.uncrown();
    this.enemies.forEach((enemy) {
      if (enemy.id == playerId) {
        enemy.crown();
      } else {
        enemy.uncrown();
      }
    });
  }
}
