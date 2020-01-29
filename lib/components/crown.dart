import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class Crown extends SpriteComponent {
  Position position;
  Size size;

  bool show = false;

  Crown(this.position, this.size) : super.rectangle(32, 19, 'crown.png');

  @override
  void resize(Size size) {
    _updatePosition();
  }

  @override
  bool isHud() {
    return true;
  }

  @override
  void render(Canvas c) {
    if (show) {
      c.save();
      super.render(c);
      c.restore();
    }
  }

  void updateDimensions(Position position, Size size) {
    this.position = position;
    this.size = size;
    _updatePosition();
  }

  void _updatePosition() {
    this.x = position.x * size.width + (size.width / 2) - (this.width / 2);
    this.y = position.y * size.height - 25;
  }
}
