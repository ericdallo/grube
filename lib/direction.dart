import 'package:flutter/material.dart';

enum Direction { left, up, right, down }

Direction toDirection(DragUpdateDetails details) {
  if (details.delta.dx > 0) {
    return Direction.right;
  }

  if (details.delta.dx < 0) {
    return Direction.left;
  }

  if (details.delta.dy > 0) {
    return Direction.down;
  }

  return Direction.up;
}
