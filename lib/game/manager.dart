import 'package:flame/position.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:grube/components/enemy.dart';
import 'package:grube/direction.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/game/controller.dart';
import 'package:grube/game/world.dart';
import 'package:grube/socket/manager.dart';

class GameManager {
  DoubleTapGestureRecognizer doubleTap;
  HorizontalDragGestureRecognizer horizontal;
  VerticalDragGestureRecognizer vertical;
  Util flameUtil;

  String playerId;
  bool loaded = false;

  GameController gameController;
  SocketManager socketManager;

  GameManager() {
    this.gameController = GameController(this);
    init();
  }

  void init() async {
    doubleTap = DoubleTapGestureRecognizer();
    horizontal = HorizontalDragGestureRecognizer();
    vertical = VerticalDragGestureRecognizer();

    flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    this.socketManager = SocketManager(this)..connect();

    doubleTap.onDoubleTap = gameController.onDoubleTap;
    horizontal.onStart = gameController.onDragStart;
    horizontal.onUpdate = gameController.onDragUpdate;
    horizontal.onEnd = gameController.onDragEnd;

    vertical.onStart = gameController.onDragStart;
    vertical.onUpdate = gameController.onDragUpdate;
    vertical.onEnd = gameController.onDragEnd;

    flameUtil.addGestureRecognizer(horizontal);
    flameUtil.addGestureRecognizer(vertical);
    flameUtil.addGestureRecognizer(doubleTap);
  }

  Widget start() {
    return gameController.widget;
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
            World.instance.load(gameController, playerAdded, payload['world']);
            this.loaded = true;
            break;
          }
          World.instance.addEnemy(Enemy.from(gameController, playerAdded));
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
          World.instance.player.scorePoint(payload['score']);
          break;
      }
    });
  }
}
