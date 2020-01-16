import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/game/manager.dart';

class SocketManager {
  GameManager gameManager;
  String url;

  WebSocketChannel channel;
  String playerId;

  SocketManager(this.gameManager) {
    initialize();
  }

  void initialize() async {
    url = "${SecretManager.secrets.apiURL}/chsk?client-id=123";
  }

  void connect() {
    channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(
      (message) {
        var json = jsonDecode(message.substring(1));
        if (json is String) {
          return;
        }
        gameManager.handleMessage(json);
      },
      onError: (error, StackTrace stackTrace) {
        print("error: $error");
      },
    );
  }

  void send(String action, message) async {
    var finalMessage = ["grube/$action", message];
    var json = jsonEncode(finalMessage);
    channel.sink.add("-$json");
  }
}
