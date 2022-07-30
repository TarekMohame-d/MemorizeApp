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
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeLayout(),
          ),
        );
      },
    );
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _text1 = 'Memo';
        _text2 = 'rize';
      });
    });
  }

  String _text1 = '';
  String _text2 = '';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _text1,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xff4893FF),
                    ),
                  ),
                  Text(
                    _text2,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Product Sans',
                      fontWeight: FontWeight.w700,
                      color: Color(0xffFF9D22),
                    ),
                  ),
                ],
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
