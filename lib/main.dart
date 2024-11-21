import 'package:flutter/material.dart';
import 'package:quote_app/component/AppBar.dart';
import 'Screen/SettingScreen.dart';

void main() {
  runApp(const MaterialApp(
    home: AppView(),
  ));
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsView()),
              );
            },
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "AppView screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
