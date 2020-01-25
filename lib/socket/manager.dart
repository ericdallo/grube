import 'dart:convert';

import 'package:grube/config/secret.dart';
import 'package:grube/game/manager.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

final logger = Logger();

class SocketManager {
  GameManager gameManager;
  String url;

  WebSocketChannel channel;
  String playerId;

  SocketManager(this.gameManager) {
    initialize();
  }

  void initialize() async {
    var uuid = Uuid().v1();
    url = "${SecretManager.secrets.apiURL}/chsk?client-id=$uuid";
  }

  void connect() async {
    this.channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(
      (message) {
        var json = jsonDecode(message.substring(1));
        if (json is String) {
          return;
        }
        gameManager.handleMessage(json);
      },
      onError: (error, StackTrace stackTrace) async {
        logger.e(error);
        if (error is WebSocketChannelException) {
          await Future.delayed(Duration(seconds: 1));
          connect();
        }
      },
    );
  }

  void disconnect() async {
    channel.sink.close(status.goingAway);
  }

  void send(String action, message) async {
    var finalMessage = ["grube/$action", message];
    var json = jsonEncode(finalMessage);
    channel.sink.add("-$json");
  }
}
