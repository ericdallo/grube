import 'package:flutter/cupertino.dart';
import 'package:grube/game/ui/screen.dart';

class _Stamina {
  int _time = 0;
  double _width = 100;
  bool _visible = false;

  int get time => _time;
  double get width => _width;
  bool get visible => _visible;

  void setCharged() {
    this._time = 0;
    this._width = 100;
    this._visible = false;
  }

  void setTime(int staminaTime) {
    this._visible = true;
    this._width = 0;
    this._time = staminaTime;
  }
}

const MAX_LIFE = 3;

class GameState {
  final _Stamina stamina = _Stamina();

  UIScreen currentScreen = UIScreen.menu;

  int _score = 0;
  int _life = MAX_LIFE;

  int get life => _life;
  int get score => _score;

  void setScore(int score) {
    this._score = score;
  }

  void setLife(int life) {
    this._life = life;
  }

  void changeScreen(UIScreen screen) {
    this.currentScreen = screen;
  }
}

class _GameStateProvider extends InheritedWidget {
  final GameStateProviderState data;

  _GameStateProvider({
    @required Widget child,
    @required this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class GameStateProvider extends StatefulWidget {
  final GameState data;
  final Widget child;

  GameStateProvider({
    @required this.child,
    @required this.data,
  });

  static GameStateProviderState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_GameStateProvider>()
        .data;
  }

  @override
  GameStateProviderState createState() => GameStateProviderState(data);
}

class GameStateProviderState extends State<GameStateProvider> {
  GameState gameState;

  GameStateProviderState(this.gameState);

  UIScreen currentScreen() => gameState.currentScreen;

  void changeScreen(UIScreen screen) {
    setState(() {
      gameState.changeScreen(screen);
    });
  }

  void staminaCharged() {
    setState(() {
      gameState.stamina.setCharged();
    });
  }

  void staminaTime(int staminaTime) {
    setState(() {
      gameState.stamina.setTime(staminaTime);
    });
  }

  void score(int score) {
    setState(() {
      gameState.setScore(score);
    });
  }

  void life(int life) {
    setState(() {
      gameState.setLife(life);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _GameStateProvider(
      data: this,
      child: widget.child,
    );
  }
}
