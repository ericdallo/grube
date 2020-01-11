import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/world.dart';

class SocketManager {
  GameController gameController;
  WebSocketChannel channel;
  String playerId;

  SocketManager(this.gameController) {
    initialize();
  }

  void initialize() async {
    String wsURL = "${SecretManager.secrets.apiURL}/chsk?client-id=123";

    channel = IOWebSocketChannel.connect(wsURL);
    channel.stream.listen(
      (message) {
        var json = jsonDecode(message.substring(1));
        if (json is String) {
          return;
        }
        handleMessage(json);
      },
      onError: (error, StackTrace stackTrace) {
        print("error: $error");
      },
    );
  }

  void handleMessage(List<dynamic> json) async {
    if (playerId == null) {
      playerId = json.last[0];
      return;
    }

    json.forEach((value) {
      var world = World.from(gameController, playerId, value[1]);
      gameController.onWorldUpdate(world);
    });
  }

  void send(String action, message) async {
    var finalMessage = ["grube/$action", message];
    var json = jsonEncode(finalMessage);
    channel.sink.add("-$json");
  }
}
