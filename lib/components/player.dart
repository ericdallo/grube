import 'dart:ui';

import 'package:grube/components/character.dart';
import 'package:grube/components/hurt.dart';
import 'package:grube/direction.dart';
import 'package:grube/game/game.dart';
import 'package:grube/game/world.dart';

class Player extends Character {
  Hurt _hurt;
  _Stamina _stamina;

  Player.from(Game game, Map<String, dynamic> json)
      : super(
          game,
          json: json,
          color: Color(json['color']),
        ) {
    this._hurt = Hurt.screenHurt(game);
    this._stamina = _Stamina(game, json['stamina']);
  }

  @override
  void update(double t) {
    super.update(t);
    _hurt.update(t);

    if (!_stamina.charging()) {
      return;
    }

    _stamina.update(t);
  }

  @override
  void render(Canvas c) {
    super.render(c);
    _hurt.render(c);
  }

  void move(Direction direction) {
    if (!live) {
      return;
    }

    var world = World.instance;

    bool teleportRight = position.x + 1 >= world.size.width;
    bool teleportLeft = position.x <= 0;
    bool teleportDown = position.y + 1 >= world.size.height;
    bool teleportUp = position.y <= 0;

    if (direction == Direction.right) {
      position.x = teleportRight ? 0 : position.x + 1;
    }

    if (direction == Direction.left) {
      position.x = teleportLeft ? world.size.width - 1 : position.x - 1;
    }

    if (direction == Direction.down) {
      position.y = teleportDown ? 0 : position.y + 1;
    }

    if (direction == Direction.up) {
      position.y = teleportUp ? world.size.height - 1 : position.y - 1;
    }

    this.direction = direction;
    game.playerMoved(direction, position);
  }

  void shoot() {
    if (!live || _stamina.charging()) {
      return;
    }

    var bulletPosition = position.clone();

    if (direction == Direction.right) {
      bulletPosition.x++;
    }

    if (direction == Direction.left) {
      bulletPosition.x--;
    }

    if (direction == Direction.down) {
      bulletPosition.y++;
    }

    if (direction == Direction.up) {
      bulletPosition.y--;
    }

    _stamina.tire();
    game.playerShot(direction, bulletPosition, _stamina.refuelTime());
  }

  void hit() {
    super.hit();
    _hurt.hurt();
    game.playerHurted();
  }
}

class _Stamina {
  final Game game;
  double _timer = 0;
  bool _charging = false;
  int _refuelTime;

  _Stamina(this.game, int stamina) {
    this._refuelTime = stamina * 100;
  }

  bool charging() => _charging;
  int refuelTime() => _refuelTime;

  void update(double t) {
    _timer += t * 1000;

    if (_timer >= _refuelTime) {
      _charging = false;
      _timer = 0;
      game.staminaCharged();
    }
  }

  void tire() {
    _charging = true;
  }
}
