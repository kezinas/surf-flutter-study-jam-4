import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:surf_practice_magic_ball/data/ans_helper.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key});

  @override
  State<StatefulWidget> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall>
    with SingleTickerProviderStateMixin {
  String answer = '';
  AHelper helper = AHelper();
  bool onTapped = false;
  bool hasError = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    if (!(GetPlatform.isDesktop || GetPlatform.isWeb)) {
      ShakeDetector.autoStart(
          shakeThresholdGravity: 1.5,
          onPhoneShake: () async {
            onTapped = true;
            hasError = false;
            try {
              answer = await helper.getAnswer();
            } catch (e) {
              hasError = true;
              answer = '';
            }
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
      child: LoopAnimationBuilder(
        duration: Duration(seconds: 3),
        tween: Tween(begin: 10.0, end: 0.0),
        builder: (BuildContext context, value, _) {
          return Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                textDirection: TextDirection.ltr,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    margin: EdgeInsets.only(bottom: 40.0 - value, top: value),
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
                    margin: EdgeInsets.only(bottom: 40.0 - value, top: value),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                    ),
                    child: Center(
                        child: SvgPicture.asset('assets/images/star.svg')),
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    margin: EdgeInsets.only(bottom: 40.0 - value, top: value),
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
                          margin:
                              EdgeInsets.only(bottom: 40.0 - value, top: value),
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(300),
                              color: hasError
                                  ? Color.fromARGB(135, 250, 3, 3)
                                  : Color.fromARGB(136, 0, 0, 0)),
                        )
                      : Container(),
                  Container(
                    width: 300,
                    height: 300,
                    margin: EdgeInsets.only(bottom: 40.0 - value, top: value),
                    padding: EdgeInsets.all(30),
                    alignment: Alignment.center,
                    child: Text(
                      answer,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                ],
              ),
              Container(
                width: 100 - value * 2,
                height: 30,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 74, 4, 83),
                    borderRadius: BorderRadius.all(Radius.elliptical(100, 50))),
              )
            ],
          );
        },
      ),
    );
  }
}
