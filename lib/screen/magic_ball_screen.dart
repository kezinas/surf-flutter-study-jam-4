import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/widgets/magic_ball.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MagicBallScreen extends StatelessWidget {
  MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String hintText =
        'Нажмите на шар${GetPlatform.isDesktop || GetPlatform.isWeb ? '' : (' или потрясите ${MediaQuery.of(context).size.shortestSide < 550 ? 'телефон' : 'планшет'}')}';
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(top: 200),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.black,
              Color.fromARGB(255, 4, 4, 70),
              Color.fromARGB(255, 46, 2, 52),
              Color.fromARGB(255, 74, 4, 83),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.3, 0.8, 0.95]),
      ),
      child: Column(children: [
        MagicBall(),
        Text(
          hintText,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        )
      ]),
    ));
  }
}
