import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_opener_1/constants/constants.dart';
import 'package:flutter_opener_1/screens/home.dart';
import 'package:flutter_opener_1/widgets/splash_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Route _createRoute() {
    return PageRouteBuilder(
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(
        milliseconds: 800,
      ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const HomeScreen();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void startTimeToNavigate() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then((value) {
      Navigator.push(
        context,
        _createRoute(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SplashBody(
        onComplete: startTimeToNavigate,
      ),
    );
  }
}
