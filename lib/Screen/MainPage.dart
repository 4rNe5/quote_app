import 'package:flutter/material.dart';
import 'package:quote_app/logic/GetQuoteData.dart';
import 'package:quote_app/component/AppBar.dart';
import 'package:quote_app/Screen/SettingScreen.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:quote_app/model/QuoteClass.dart';
import 'package:quote_app/component/QuoteSwipeCard.dart'; // 새로 생성한 컴포넌트 import

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.title});

  final String? title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SwipeItem> _swipeItems = [];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initQuotes();
  }

  Future<void> _initQuotes() async {
    try {
      List<Quote> quotes = await fetchQuotes();
      setState(() {
        _swipeItems = quotes.map((quote) {
          return SwipeItem(
            content: quote,
          );
        }).toList();

        _matchEngine = MatchEngine(swipeItems: _swipeItems);
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching quotes: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: widget.title,
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
      backgroundColor: Color(0xFFE3E3E3),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _swipeItems.isEmpty
          ? const Center(child: Text("No quotes available"))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuoteSwipeCard(
              swipeItems: _swipeItems,
              matchEngine: _matchEngine!,
              onStackFinished: () => _showSnackBar("No more quotes"),
            ),
            const SizedBox(height: 90.0), // 카드 영역 아래에 여백 추가
          ],
        ),
      ),
    );
  }
}