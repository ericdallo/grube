import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:grube/config/secret.dart';
import 'package:grube/game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  SecretManager.init();

  DoubleTapGestureRecognizer doubleTap = DoubleTapGestureRecognizer();

  HorizontalDragGestureRecognizer horizontal =
      HorizontalDragGestureRecognizer();
  VerticalDragGestureRecognizer vertical = VerticalDragGestureRecognizer();

  GameController gameController = GameController();

  doubleTap.onDoubleTap = gameController.onDoubleTap;
  horizontal.onStart = gameController.onDragStart;
  horizontal.onUpdate = gameController.onDragUpdate;
  horizontal.onEnd = gameController.onDragEnd;

  vertical.onStart = gameController.onDragStart;
  vertical.onUpdate = gameController.onDragUpdate;
  vertical.onEnd = gameController.onDragEnd;

  runApp(gameController.widget);
  flameUtil.addGestureRecognizer(horizontal);
  flameUtil.addGestureRecognizer(vertical);
  flameUtil.addGestureRecognizer(doubleTap);
}
