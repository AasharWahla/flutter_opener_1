import 'package:flutter/material.dart';
import 'package:flutter_opener_1/constants/constants.dart';
import 'package:flutter_opener_1/screens/home.dart';

import 'expandingCircle.dart';

class SplashBody extends StatefulWidget {
  SplashBody({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool startFirst = false;
  bool startSecond = false;
  bool startFinalCircle = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  void startAnimation() {
    _controller = AnimationController(vsync: this);
    _controller.duration = Duration(
      seconds: 2,
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
      reverseCurve: Curves.easeOut,
    );

    _controller.forward();
    _controller.addListener(
      () {
        if (animation.value == 1) {
          _controller.reverse();
        } else if (animation.status == AnimationStatus.reverse) {
          if (animation.value <= 0.5) {
            _controller.stop();
            setState(
              () {
                startFirst = true;
                print('start first is true.');
              },
            );
            Future.delayed(Duration(seconds: 1)).then(
              (value) {
                print("second circle start");
                setState(
                  () {
                    startSecond = true;
                  },
                );
                Future.delayed(Duration(seconds: 1)).then(
                  (value) {
                    print("second circle start");
                    setState(() {
                      startFinalCircle = true;
                    });
                    widget.onComplete();
                  },
                );
              },
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: SizedBox(),
        ),
        if (startFirst)
          Positioned.fill(
            child: Center(
              child: ExpandingCircle(
                circleColor: Colors.green,
              ),
            ),
          ),
        if (startSecond)
          Positioned.fill(
            child: Center(
              child: ExpandingCircle(
                circleColor: Colors.red,
              ),
            ),
          ),
        AnimatedBuilder(
          animation: animation,
          builder: (ctx, chil) {
            return Positioned(
              left: width / 2 - 50,
              top: (height * animation.value) - 50,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'AW',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (startFinalCircle)
          Positioned.fill(
            child: Center(
              child: ExpandingCircle(
                circleColor: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
