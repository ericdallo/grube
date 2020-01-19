import 'dart:math' as math;

import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final int _score;

  Score(this._score);

  @override
  Widget build(BuildContext context) {
    return Text(
      _score.toStringAsFixed(0),
      style: TextStyle(
        fontSize: 36,
        color: Colors.black,
      ),
    );
  }
}

class Lifes extends StatelessWidget {
  final int maxLife;
  final int currentLife;

  Lifes({this.maxLife, this.currentLife});

  @override
  Widget build(BuildContext context) {
    List<Widget> hearts = [];
    for (var i = 1; i <= maxLife; i++) {
      if (i <= currentLife) {
        hearts.add(_buildFullHeart());
      } else {
        hearts.add(_buildEmptyHeart());
      }
    }

    return Row(children: hearts);
  }

  Widget _buildFullHeart() {
    return Image.asset(
      'assets/images/full_life.png',
      width: 36,
      height: 30,
    );
  }

  Widget _buildEmptyHeart() {
    return Image.asset(
      'assets/images/empty_life.png',
      width: 36,
      height: 30,
    );
  }
}

class Stamina extends StatelessWidget {
  final double innerWidth;
  final int time;
  final bool visible;

  Stamina({
    @required this.innerWidth,
    @required this.time,
    @required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    double opacity = visible ? 1 : 0;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Container(
        alignment: Alignment.centerLeft,
        width: 100,
        height: 12,
        color: Color(0xFF3498db),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration.zero,
            child: AnimatedContainer(
              color: Colors.white,
              width: innerWidth,
              duration: Duration(milliseconds: time),
              curve: Curves.linear,
            ),
          ),
        ),
      ),
    );
  }
}
