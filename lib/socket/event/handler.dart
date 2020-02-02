import 'package:flame/position.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/socket/event/events.dart';
import 'package:grube/socket/event/messages.dart';

class EventHandler {
  final Game game;
  String playerId;

  EventHandler(GameManager gameManager) : this.game = gameManager.game;

  void handle(rawEvents) async {
    if (rawEvents[0] == "chsk/handshake") {
      playerId = rawEvents.last[0];
      return;
    }

    Messages.fromJson(rawEvents).events.forEach(handleSingleEvent);
  }

  void handleSingleEvent(Message message) {
    String eventName = message.name;

    if (eventName == "game/player-added") {
      var data = message.data(PlayerAddedEvent());

      if (playerId == data.player.id) {
        game.load(data.player, data.world);
        return;
      }
    }

    if (!game.loaded) {
      return;
    }

    switch (eventName) {
      case "game/player-added":
        game.addEnemy(message.data(EnemyAddedEvent()).enemy);
        break;
      case "game/player-removed":
        game.removeEnemy(message.data(EnemyRemovedEvent()).enemyId);
        break;
      case "game/enemy-paused":
        game.pauseEnemy(message.data(EnemyPausedEvent()).enemyId);
        break;
      case "game/enemy-resumed":
        game.resumeEnemy(message.data(EnemyResumedEvent()).enemyId);
        break;
      case "game/player-moved":
        var character = message.data(PlayerMovedEvent()).player;

        if (playerId != character.id) {
          Position position = Position(
            character.position.x,
            character.position.y,
          );
          game.moveEnemy(character.id, position, character.direction);
        }
        break;
      case "game/player-shot":
        var bullets = message.data(PlayerShotEvent()).bullets;
        game.playerShot(bullets);
        break;
      case "game/enemy-shot":
        var event = message.data(EnemyShotEvent());
        game.enemyShot(event.enemyId, event.bullets);
        break;
      case "game/bullets-moved":
        var event = message.data(BulletsMovedEvent());
        var bullets = event.bulletsByPlayer;
        game.moveBullets(bullets);
        break;
      case "game/players-hitted":
        game.hitPlayers(message.data(PlayersHittedEvent()).playerIds);
        break;
      case "game/player-scored":
        var event = message.data(PlayerScoredEvent());
        game.playerScore(event.score, event.crownedPlayerId);
        break;
      case "game/enemies-scored":
        var event = message.data(EnemiesScoredEvent());
        game.enemiesScored(event.enemies, event.crownedPlayerId);
        break;
      case 'game/player-respawned':
        var event = message.data(PlayerRespawnedEvent());
        var player = event.player;
        Position position = Position(
          player.position.x,
          player.position.y,
        );

        if (player.id == playerId) {
          game.playerRespawned(player.life, position);
        } else {
          game.enemyRespawned(player.id, player.life, position);
        }

        break;
    }
  }
}
