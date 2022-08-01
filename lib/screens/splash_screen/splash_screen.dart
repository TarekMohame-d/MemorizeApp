import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeLayout(),
          ),
        );
      },
    );
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(
                flex: 2,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 70.0,
                child: Image.asset(
                  'assets/images/translation.png',
                  scale: 4.0,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              AnimatedOpacity(
                opacity: visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Memo',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff4893FF),
                      ),
                    ),
                    Text(
                      'rize',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.w700,
                        color: Color(0xffFF9D22),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              Text(
                'from',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18.0,
                  fontFamily: 'Product Sans',
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Tarek dev.',
                    speed: const Duration(milliseconds: 200),
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Product Sans',
                    ),
                    colors: [
                      Colors.purple,
                      Colors.blue,
                      Colors.yellow,
                      Colors.red,
                    ],
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
