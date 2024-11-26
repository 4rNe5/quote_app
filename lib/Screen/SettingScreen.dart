import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quote_app/component/AppBar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isChecked = false; // 토글 저장

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      appBar: const CustomAppBar(
        title: "설정",
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "알림 허용",
                    style: TextStyle(fontSize: 18),
                  ),
                  CupertinoSwitch(
                    value: _isChecked,
                    activeColor: CupertinoColors.activeBlue,
                    onChanged: (bool value) {
                      setState(() {
                        _isChecked = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "약관 및 개인정보",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.chevron_right),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "버전 정보",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "현재 1.0",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
