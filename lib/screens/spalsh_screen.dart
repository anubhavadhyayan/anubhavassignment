import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:anubhavassignment/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 10),
      () => Get.off(
        () => ProductScreen(),
        transition: Transition.zoom,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 20.0, height: 100.0),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 50.0,
                fontFamily: 'Horizon',
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('Anubhav'),
                  RotateAnimatedText('Assignment'),
                  RotateAnimatedText('Project'),
                  RotateAnimatedText("Let's Go"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
