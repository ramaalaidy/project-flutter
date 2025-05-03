import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'welcome.page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/AQ.png'),
      nextScreen: WelcomePage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blueAccent,
      duration: 5000,
    );
  }
}
