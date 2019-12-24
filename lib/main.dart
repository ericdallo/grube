import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/game_controller.dart';
import 'package:grube/socket_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  GameController gameController = GameController();
  PanGestureRecognizer pan = PanGestureRecognizer();
  pan.onUpdate = gameController.onPanUpdate;

  runApp(gameController.widget);
  flameUtil.addGestureRecognizer(pan);
}
