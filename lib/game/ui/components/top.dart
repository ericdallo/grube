import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:grube/game/state.dart';

class TopUI extends StatelessWidget {
  const TopUI();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            children: [
              const _Lifes(),
              const Expanded(child: Center()),
              const _Score(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Row(
              children: [
                const _Stamina(),
                const Expanded(child: Center()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score();

  @override
  Widget build(BuildContext context) {
    var gameState = GameStateProvider.of(context).gameState;

    return Text(
      gameState.score.toStringAsFixed(0),
      style: const TextStyle(
        fontSize: 36,
        color: Colors.black,
      ),
    );
  }
}

class _Lifes extends StatelessWidget {
  const _Lifes();

  @override
  Widget build(BuildContext context) {
    var gameState = GameStateProvider.of(context).gameState;

    List<Widget> hearts = [];
    for (var i = 1; i <= MAX_LIFE; i++) {
      if (i <= gameState.life) {
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

class _Stamina extends StatelessWidget {
  const _Stamina();
 
  @override
  Widget build(BuildContext context) {
    var gameState = GameStateProvider.of(context).gameState;

    double opacity = gameState.stamina.visible ? 1 : 0;

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
              width: gameState.stamina.width,
              duration:  Duration(milliseconds: gameState.stamina.time),
              curve: Curves.linear,
            ),
          ),
        ),
      ),
    );
  }
}
