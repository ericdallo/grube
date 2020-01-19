import 'package:flame/position.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/ui.dart';
import 'package:grube/game/world.dart';
import 'package:grube/helpers/audios.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/socket/manager.dart';

class GameManager {
  DoubleTapGestureRecognizer doubleTap;
  HorizontalDragGestureRecognizer horizontal;
  VerticalDragGestureRecognizer vertical;
  Util flameUtil;

  String playerId;

  GameUI gameUI;
  Game game;
  SocketManager socketManager;

  GameManager() {
    this.gameUI = GameUI();
    this.game = Game(this, gameUI);

    gameUI.state.game = game;

    init();
  }

  void init() async {
    SecretManager.init();
    Audios.instance.loadAll();
    doubleTap = DoubleTapGestureRecognizer();
    horizontal = HorizontalDragGestureRecognizer();
    vertical = VerticalDragGestureRecognizer();

    flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    this.socketManager = SocketManager(this);

    doubleTap.onDoubleTap = game.onDoubleTap;
    horizontal.onStart = game.onDragStart;
    horizontal.onUpdate = game.onDragUpdate;
    horizontal.onEnd = game.onDragEnd;

    vertical.onStart = game.onDragStart;
    vertical.onUpdate = game.onDragUpdate;
    vertical.onEnd = game.onDragEnd;

    flameUtil.addGestureRecognizer(horizontal);
    flameUtil.addGestureRecognizer(vertical);
    flameUtil.addGestureRecognizer(doubleTap);
  }

  void start() {
    this.socketManager.connect();
  }

  void handleMessage(List<dynamic> json) async {
    if (playerId == null) {
      playerId = json.last[0];
      return;
    }

    json.forEach((event) {
      String eventName = event[0];
      var payload = event[1];

      switch (eventName) {
        case "game/player-added":
          var playerAdded = payload['player'];

          if (playerId == playerAdded['id']) {
            game.load(playerAdded, payload['world']);
            break;
          }
          World.instance.addEnemy(Enemy.from(game, playerAdded));
          break;
        case "game/player-removed":
          World.instance.removeEnemy(payload['player-id']);
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
            World.instance.moveEnemy(player['id'], position, direction);
          }
          break;
        case "game/bullets-moved":
          var bullets = payload['bullets-by-player'];
          World.instance.moveBullets(bullets);
          break;
        case "game/players-hitted":
          List<String> playerIds = payload['player-ids'].cast<String>();
          World.instance.hitPlayers(playerIds);
          break;
        case "game/player-scored":
          game.score(payload['score']);
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
            game.enemyRespawned(player.id, player['life'], position);
          }

          break;
      }
    });
  }
}
