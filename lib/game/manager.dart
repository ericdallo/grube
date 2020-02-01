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

  void handleMessage(List<dynamic> json) async {
    if (json[0] == "chsk/handshake") {
      playerId = json.last[0];
      return;
    }

    json.forEach((event) {
      String eventName = event[0];
      var payload = event[1];

      if (eventName == "game/player-added" &&
          playerId == payload['player']['id']) {
        game.load(payload['player'], payload['world']);
        return;
      }

      if (!game.loaded) {
        return;
      }

      switch (eventName) {
        case "game/player-added":
          game.addEnemy(payload['player']);
          break;
        case "game/player-removed":
          game.removeEnemy(payload['player-id']);
          break;
        case "game/enemy-paused":
        game.pauseEnemy(payload['enemy-id']);
          break;
        case "game/enemy-resumed":
        game.resumeEnemy(payload['enemy-id']);
          break;
        case "game/player-moved":
          var player = payload['player'];

          if (playerId != player['id']) {
            Direction direction =
                Enums.fromString(Direction.values, player['direction']);
            Position position = Position(
              player['position']['x'],
              player['position']['y'],
            );
            game.moveEnemy(player['id'], position, direction);
          }
          break;
        case "game/player-shot":
          var bullets = payload['bullets'];
          game.playerShot(bullets);
          break;
        case "game/enemy-shot":
          var bullets = payload['bullets'];
          game.enemyShot(payload['enemy-id'], bullets);
          break;
        case "game/bullets-moved":
          var bullets = payload['bullets-by-player'];
          game.moveBullets(bullets);
          break;
        case "game/players-hitted":
          List<String> playerIds = payload['player-ids'].cast<String>();
          game.hitPlayers(playerIds);
          break;
        case "game/player-scored":
          String crownedPlayer = payload['crowned-player'];
          game.playerScore(payload['score'], crownedPlayer);
          break;
        case "game/enemies-scored":
          String crownedPlayer = payload['crowned-player'];
          game.enemiesScored(payload['enemies'], crownedPlayer);
          break;
        case 'game/player-respawned':
          var player = payload['player'];
          Position position = Position(
            player['position']['x'],
            player['position']['y'],
          );

          if (player['id'] == playerId) {
            game.playerRespawned(player['life'], position);
          } else {
            game.enemyRespawned(player['id'], player['life'], position);
          }

          break;
      }
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
