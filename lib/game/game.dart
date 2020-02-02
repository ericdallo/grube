import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/ui/screen.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/audios.dart';
import 'package:grube/socket/event/data.dart';

class Game extends BaseGame {
  Game._();

  static Game _instance;

  static Game get instance {
    return _instance ??= Game._();
  }

  GameManager gameManager;

  Size screenSize;

  bool canMove;
  bool loaded = false;

  Game(this.gameManager) {
    initialize();
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
  }

  @override
  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFFFAFAFA);
    c.drawRect(background, backgroundPaint);

    if (!loaded) {
      return;
    }

    var world = World.instance;

    world.enemies.forEach((enemy) => enemy.render(c));
    world.player.render(c);
  }

  @override
  void update(double t) {
    if (!loaded) {
      return;
    }

    var world = World.instance;

    world.enemies.forEach((enemy) => enemy.update(t));
    world.player.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.screenSize = size;
  }

  void onDoubleTap() {
    if (!loaded) {
      return;
    }
    World.instance.player.shoot();
  }

  void onDragStart(DragStartDetails details) {
    this.canMove = true;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (canMove && loaded) {
      World.instance.player.move(toDirection(details));
    }
    this.canMove = false;
  }

  void onDragEnd(DragEndDetails details) {
    this.canMove = true;
  }

  void movePlayer(Direction direction, Position position) =>
      this.gameManager.movePlayer(direction, position);

  void playerShoot(Direction direction, Position position, int staminaTime) =>
      this.gameManager.playerShoot(direction, position, staminaTime);

  void staminaCharged() => gameManager.stateProvider.staminaCharged();

  void load(CharacterData player, WorldData world) {
    World.instance.load(this, player, world);
    this.loaded = true;
    gameManager.stateProvider.changeScreen(UIScreen.playing);
  }

  void unload() {
    this.loaded = false;
    gameManager.playerId = null;
    World.instance.unload();
  }

  void addEnemy(CharacterData enemy) =>
      World.instance.addEnemy(Enemy.from(this, enemy));

  void removeEnemy(String playerId) => World.instance.removeEnemy(playerId);

  void pauseEnemy(String enemyId) => World.instance.pauseEnemy(enemyId);

  void resumeEnemy(String enemyId) => World.instance.resumeEnemy(enemyId);

  void moveEnemy(String enemyId, Position position, Direction direction) =>
      World.instance.moveEnemy(enemyId, position, direction);

  void playerShot(bullets) => World.instance.playerShot(bullets);

  void enemyShot(String enemyId, List<BulletData> bullets) =>
      World.instance.enemyShot(enemyId, bullets);

  void moveBullets(bulletsByPlayer) =>
      World.instance.moveBullets(bulletsByPlayer);

  void hitPlayers(List<String> playerIds) =>
      World.instance.hitPlayers(playerIds);

  void playerScore(int score, String crownedPlayerId) async {
    Flame.audio.play(Audios.score);
    gameManager.stateProvider.score(score);
    World.instance.updateCrownedPlayer(crownedPlayerId);
  }

  void enemiesScored(
      List<CharacterData> enemies, String crownedPlayerId) async {
    World.instance.enemiesScored(enemies);
    World.instance.updateCrownedPlayer(crownedPlayerId);
  }

  void playerHurted() async {
    var world = World.instance;
    gameManager.stateProvider.life(world.player.life);

    if (world.player.live) {
      Flame.audio.play(Audios.hurt);
    } else {
      Flame.audio.play(Audios.gameOver);
      gameManager.stateProvider.changeScreen(UIScreen.gameOver);
    }
  }

  void playerRespawned(int life, Position position) async {
    var world = World.instance;
    world.player.life = life;
    world.player.position = position;
    gameManager.stateProvider.life(life);
    gameManager.stateProvider.changeScreen(UIScreen.playing);
  }

  void enemyRespawned(String enemyId, int life, Position position) async {
    var world = World.instance;
    Enemy enemy = world.enemies.singleWhere((enemy) => enemy.id == enemyId);

    enemy.life = life;
    enemy.position = position;
  }
}
