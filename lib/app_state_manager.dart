import 'package:flutter/material.dart';
import 'package:grube/game/manager.dart';
import 'package:grube/game/ui/screen.dart';

class AppStateManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppStateManagerState();
}

class _AppStateManagerState extends State<AppStateManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var gameManager = GameManager.instance(context);

    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        gameManager.pause();
        break;
      case AppLifecycleState.resumed:
        gameManager.resume();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        gameManager.stateProvider.changeScreen(UIScreen.menu);
        gameManager.stop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var gameManager = GameManager.instance(context);

    return WillPopScope(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: gameManager.game.widget,
            ),
            Positioned.fill(
              child: gameManager.ui,
            )
          ],
        ),
      ),
      onWillPop: gameManager.onBackPressed,
    );
  }
}
