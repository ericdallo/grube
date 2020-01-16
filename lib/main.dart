import 'package:flutter/widgets.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/game/manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SecretManager.init();

  GameManager gameManager = GameManager();

  runApp(gameManager.start());
}
