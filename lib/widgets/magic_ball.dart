import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_practice_magic_ball/data/ans_helper.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<StatefulWidget> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  String answer = '';
  AHelper helper = AHelper();
  bool onTapped = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if (!(GetPlatform.isDesktop || GetPlatform.isWeb)) {
      ShakeDetector.autoStart(
          shakeThresholdGravity: 1.5,
          onPhoneShake: () async {
            onTapped = true;
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
        onTapped = true;
        hasError = false;
        try {
          answer = await helper.getAnswer();
        } catch (e) {
          hasError = true;
          answer = '';
        }

        setState(() {});
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
              border: Border.all(),
              image: DecorationImage(
                image: AssetImage('assets/images/ball_sc.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
            ),
            child: Center(child: SvgPicture.asset('assets/images/star.svg')),
          ),
          Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.only(bottom: 40),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300),
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/images/small star.svg',
            )),
          ),
          onTapped
              ? Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.only(bottom: 40),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      color: hasError
                          ? Color.fromARGB(135, 250, 3, 3)
                          : Color.fromARGB(136, 0, 0, 0)),
                )
              : Container(),
          Text(
            answer,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
