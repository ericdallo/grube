import 'dart:convert';

import 'package:grube/config/secret.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/ui/ui.dart';
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
  bool tryConnect = true;

  SocketManager(this.gameManager) {
    initialize();
  }

  void initialize() async {
    var uuid = Uuid().v1();
    url = "${SecretManager.secrets.apiURL}/chsk?client-id=$uuid";
  }

  void handleMsg(message) async {
    var json = jsonDecode(message.substring(1));
    if (json is String) {
      return;
    }
    gameManager.handleMessage(json);
  }

  void handleError(error, StackTrace stackTrace) async {
    logger.e(error);
    if (error is WebSocketChannelException) {
      await Future.delayed(Duration(seconds: 1));
      reconnect();
    }
  }

  void connect() async {
    this.tryConnect = true;
    this.channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(
      handleMsg,
      onError: handleError,
      onDone: () async {
        if (gameManager.gameUI.state.currentScreen == UIScreen.playing) {
          reconnect();
        }
      },
    );
  }

  void reconnect() async {
    gameManager.gameUI.changeScreen(UIScreen.reconnecting);
    if (!tryConnect) {
      return;
    }

    this.channel = IOWebSocketChannel.connect(url);
    channel.stream.listen(
      (message) {
        gameManager.gameUI.changeScreen(UIScreen.playing);
        handleMsg(message);
      },
      onError: handleError,
      onDone: () async {
        if (gameManager.gameUI.state.currentScreen == UIScreen.playing) {
          await Future.delayed(Duration(seconds: 1));
          reconnect();
        }
      },
    );
  }

  void disconnect() async {
    tryConnect = false;
    channel.sink.close(status.goingAway);
  }

  void send(String action, message) async {
    var finalMessage = ["grube/$action", message];
    var json = jsonEncode(finalMessage);
    channel.sink.add("-$json");
  }
}
