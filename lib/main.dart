import 'package:flutter/material.dart';
import 'package:quote_app/component/AppBar.dart';
import 'Screen/SettingScreen.dart';
import 'package:quote_app/logic/GetQuoteData.dart';
import 'package:quote_app/Screen/MainPage.dart';

void main() {
  runApp(const MaterialApp(
    home: AppView(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}
