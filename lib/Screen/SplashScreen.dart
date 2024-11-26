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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(), // 로딩 인디케이터
            const SizedBox(height: 20),
            const Text(
              '로딩 중...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ), // 로딩 메시지
          ],
        ),
      ),
    );
  }
}