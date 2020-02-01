import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:grube/helpers/audios.dart';

class GameButton extends StatefulWidget {
  final _GameButtonState _state;

  GameButton({
    @required String text,
    @required double fontSize,
    @required VoidCallback onPressed,
  }) : this._state = _GameButtonState(text, fontSize, onPressed);

  @override
  State<StatefulWidget> createState() => _state;
}

class _GameButtonState extends State<GameButton>
    with SingleTickerProviderStateMixin {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  _GameButtonState(this.text, this.fontSize, this.onPressed);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 70),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          this.onPressed();
        }
      });

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.04, 0.1),
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _pressed,
      onTapUp: _unPressedOnTapUp,
      onTapCancel: _unPressed,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SlideTransition(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            position: _offsetAnimation,
          ),
        ),
      ),
    );
  }

  void _pressed(_) {
    _controller.forward();
    Flame.audio.play(Audios.click);
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {}
}
