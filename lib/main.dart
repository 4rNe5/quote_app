import 'package:flutter/material.dart';
import 'package:quote_app/component/AppBar.dart';
import 'Screen/SettingScreen.dart';
import 'package:quote_app/logic/GetQuoteData.dart';
import 'package:quote_app/Screen/SplashScreen.dart';
import 'package:quote_app/Screen/MainPage.dart';

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
          seedColor: Color(0xFFE3E3E3), // 원하는 Hex 코드
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
