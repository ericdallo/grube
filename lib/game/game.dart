import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/ui.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/audios.dart';
import 'package:grube/helpers/enums.dart';

class Game extends BaseGame {
  GameManager gameManager;
  GameUI ui;

  Size screenSize;

  Random random;

  bool canMove;
  bool loaded = false;

  Game(this.gameManager, this.ui) {
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

  void start() {
    gameManager.start();
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
      World.instance.player.move(_toDirection(details));
    }
    this.canMove = false;
  }

  void onDragEnd(DragEndDetails details) {
    this.canMove = true;
  }

  void playerMoved(Direction direction, Position position) async {
    this.gameManager.socketManager.send("move-player", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y
    });
  }

  void playerShot(
    Direction direction,
    Position position,
    int staminaTime,
  ) async {
    ui.staminaTime(staminaTime);
    Flame.audio.play(Audios.shoot);
    this.gameManager.socketManager.send("player-shoot", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y,
    });
  }

  void staminaCharged() {
    ui.staminaCharged();
  }

  void load(player, world) {
    World.instance.load(this, player, world);
    this.loaded = true;
    ui.changeScreen(UIScreen.playing);
  }

  void score(int score) async {
    Flame.audio.play(Audios.score);
    ui.score(score);
  }

  void playerHurted() {
    var world = World.instance;
    ui.life(world.player.life);

    if (world.player.live) {
      Flame.audio.play(Audios.hurt);
    } else {
      Flame.audio.play(Audios.gameOver);
      ui.changeScreen(UIScreen.gameOver);
    }
  }

  void respawn() async {
    this.gameManager.socketManager.send("player-respawn", {});
  }

  void playerRespawned(int life, Position position) async {
    var world = World.instance;
    world.player.life = life;
    world.player.position = position;
    ui.life(life);
    ui.changeScreen(UIScreen.playing);
  }

  void enemyRespawned(String enemyId, int life, Position position) async {
    var world = World.instance;
    Enemy enemy = world.enemies.singleWhere((enemy) => enemy.id == enemyId);

    enemy.life = life;
    enemy.position = position;
  }

  //TODO move to another class
  Direction _toDirection(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      return Direction.right;
    }

    if (details.delta.dx < 0) {
      return Direction.left;
    }

    if (details.delta.dy > 0) {
      return Direction.down;
    }

    return Direction.up;
  }
}
