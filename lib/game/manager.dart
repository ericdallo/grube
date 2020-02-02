import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/state.dart';
import 'package:grube/game/ui/screen.dart';
import 'package:grube/game/ui/ui.dart';
import 'package:grube/helpers/audios.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/socket/manager.dart';

class GameManager {
  Util flameUtil;

  String playerId;

  GameStateProviderState stateProvider;
  UI ui;
  Game game;
  SocketManager socketManager;

  static GameManager _instance;

  static GameManager instance(BuildContext context) {
    return _instance ??= GameManager._(context);
  }

  GameManager._(BuildContext context) {
    SecretManager.init();
    this.stateProvider = GameStateProvider.of(context);

    init();
  }

  void init() async {
    Audios.instance.loadAll();

    this.game = Game(this);
    this.ui = UI(this);

    flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    this.socketManager = SocketManager(this);
  }

  void start() {
    this.socketManager.connect();
  }

  void stop() async {
    this.game.unload();
    this.socketManager.disconnect();
  }

  void pause() async {
    this.socketManager.send("player-paused", {});
  }

  void resume() async {
    this.socketManager.send("player-resumed", {});
  }

  void respawn() async {
    this.socketManager.send("player-respawn", {});
  }

  void movePlayer(Direction direction, Position position) async {
    this.socketManager.send("move-player", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y
    });
  }

  void playerShoot(
    Direction direction,
    Position position,
    int staminaTime,
  ) async {
    this.stateProvider.staminaTime(staminaTime);
    Flame.audio.play(Audios.shoot);
    this.socketManager.send("player-shoot", {
      'direction': Enums.parse(direction),
      'x': position.x,
      'y': position.y,
    });
  }

  Future<bool> onBackPressed() async {
    UIScreen screen = stateProvider.currentScreen();
    if (screen == UIScreen.playing ||
        screen == UIScreen.connecting ||
        screen == UIScreen.menu) {
      stateProvider.changeScreen(UIScreen.menu);
      stop();
      return false;
    }

    return true;
  }
}
