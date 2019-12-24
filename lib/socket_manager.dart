import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/game_data.dart';

const String _WS_URL = "ws://192.168.0.16:8080/ws";

class SocketManager {
  GameController gameController;
  WebSocketChannel channel;

  SocketManager(this.gameController) {
    initialize();
  }

  void initialize() async {
    channel = IOWebSocketChannel.connect(_WS_URL);
    channel.stream.listen(
      (message) {
        var json = jsonDecode(message);
        gameController.onGameUpdate(GameData.from(gameController, json));
      },
      onError: (error, StackTrace stackTrace) {
        print("error: $error");
      },
    );
  }
}
