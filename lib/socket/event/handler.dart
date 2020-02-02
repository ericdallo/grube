import 'package:flame/position.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/helpers/enums.dart';
import 'package:grube/socket/event/messages.dart';
import 'package:grube/socket/event/events.dart';

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

  void handleSingleEvent(Message event) {
    String eventName = event.name;

    if (eventName == "game/player-added") {
      var data = event.data(PlayerAddedEvent());

      if (playerId == data.player.id) {
        game.load(data.player, data.world);
        return;
      }
    }

    if (!game.loaded) {
      return;
    }

    // switch (eventName) {
    //   case "game/player-added":
    //     game.addEnemy(data['player']);
    //     break;
    //   case "game/player-removed":
    //     game.removeEnemy(data['player-id']);
    //     break;
    //   case "game/enemy-paused":
    //     game.pauseEnemy(data['enemy-id']);
    //     break;
    //   case "game/enemy-resumed":
    //     game.resumeEnemy(data['enemy-id']);
    //     break;
    //   case "game/player-moved":
    //     var player = data['player'];

    //     if (playerId != player['id']) {
    //       Direction direction =
    //           Enums.fromString(Direction.values, player['direction']);
    //       Position position = Position(
    //         player['position']['x'],
    //         player['position']['y'],
    //       );
    //       game.moveEnemy(player['id'], position, direction);
    //     }
    //     break;
    //   case "game/player-shot":
    //     var bullets = data['bullets'];
    //     game.playerShot(bullets);
    //     break;
    //   case "game/enemy-shot":
    //     var bullets = data['bullets'];
    //     game.enemyShot(data['enemy-id'], bullets);
    //     break;
    //   case "game/bullets-moved":
    //     var bullets = data['bullets-by-player'];
    //     game.moveBullets(bullets);
    //     break;
    //   case "game/players-hitted":
    //     List<String> playerIds = data['player-ids'].cast<String>();
    //     game.hitPlayers(playerIds);
    //     break;
    //   case "game/player-scored":
    //     String crownedPlayer = data['crowned-player'];
    //     game.playerScore(data['score'], crownedPlayer);
    //     break;
    //   case "game/enemies-scored":
    //     String crownedPlayer = data['crowned-player'];
    //     game.enemiesScored(data['enemies'], crownedPlayer);
    //     break;
    //   case 'game/player-respawned':
    //     var player = data['player'];
    //     Position position = Position(
    //       player['position']['x'],
    //       player['position']['y'],
    //     );

    //     if (player['id'] == playerId) {
    //       game.playerRespawned(player['life'], position);
    //     } else {
    //       game.enemyRespawned(player['id'], player['life'], position);
    //     }

    //     break;
    // }
  }
}
