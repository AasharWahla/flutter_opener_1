import 'package:flutter/material.dart';

class ExpandingCircle extends StatefulWidget {
  const ExpandingCircle({
    Key? key,
    required this.circleColor,
  }) : super(key: key);
  final Color circleColor;
  @override
  _ExpandingCircleState createState() => _ExpandingCircleState();
}

class _ExpandingCircleState extends State<ExpandingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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

    _controller.forward();
    // _controller.addListener(
    //   () {
    //     if (_controller.value == 1) {
    //       _controller.stop();
    //     }
    //   },
    // );
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (ctx, child) {
        return Container(
          decoration: BoxDecoration(
            color: widget.circleColor,
            borderRadius: BorderRadius.circular(
              (height + width) * (1 - _controller.value),
            ),
          ),
          height: height * _controller.value,
          width: width * _controller.value * 2.5,
        );
      },
    );
  }
}
