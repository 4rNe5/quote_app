import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quote_app/Screen/MainPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // 3초 후 메인 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 스플래시 배경 색상
      body: Center(
        child: Image.asset(
          'assets/img/setting.png', // 로고 경로
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
