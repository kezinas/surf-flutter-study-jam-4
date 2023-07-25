import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:get/get.dart';
import 'package:surf_practice_magic_ball/data/ans_helper.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<StatefulWidget> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  String answer = '';
  AHelper helper = AHelper();

  @override
  void initState() {
    super.initState();
    if (!(GetPlatform.isDesktop || GetPlatform.isWeb)) {
      ShakeDetector.autoStart(
          shakeThresholdGravity: 1.5,
          onPhoneShake: () async {
            answer = await helper.getAnswer();
            setState(() {});
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        answer = '';
        answer = await helper.getAnswer();
        setState(() {});
      },
      child: Container(
        width: 300,
        height: 300,
        margin: const EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          border: Border.all(color: Colors.white),
        ),
        child: Center(
            child: Text(
          answer,
          style: TextStyle(color: Colors.white, fontSize: 22),
        )),
      ),
    );
  }
}
