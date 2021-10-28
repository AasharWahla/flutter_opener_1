import 'package:flutter/material.dart';

import 'expanding_circle.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key, required this.onComplete}) : super(key: key);
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
    _controller.duration = const Duration(
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
                debugPrint('start first is true.');
              },
            );
            Future.delayed(const Duration(seconds: 1)).then(
              (value) {
                debugPrint("second circle start");
                setState(
                  () {
                    startSecond = true;
                  },
                );
                Future.delayed(const Duration(seconds: 1)).then(
                  (value) {
                    debugPrint("last circle start");
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
        const Positioned.fill(
          child: SizedBox(),
        ),
        // * green circle
        if (startFirst)
          const Positioned.fill(
            child: Center(
              child: ExpandingCircle(
                circleColor: Colors.green,
              ),
            ),
          ),

        // * red circle

        if (startSecond)
          const Positioned.fill(
            child: Center(
              child: ExpandingCircle(
                circleColor: Colors.red,
              ),
            ),
          ),

        // * this is our animation

        AnimatedBuilder(
          animation: animation,
          builder: (ctx, chil) {
            return Positioned(
              left: width / 2 - 50,
              top: (height * animation.value) - 50,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
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

        // * white circle

        if (startFinalCircle)
          const Positioned.fill(
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
