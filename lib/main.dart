import 'package:flutter/material.dart';
import 'package:quote_app/Screen/SplashScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE3E3E3), // 원하는 Hex 코드
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
