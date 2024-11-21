import 'package:flutter/material.dart';
import 'package:quote_app/logic/GetQuoteData.dart';
import 'package:quote_app/component/AppBar.dart';
import 'package:quote_app/Screen/SettingScreen.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:quote_app/model/QuoteClass.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.title});

  final String? title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
      });
    } catch (e) {
      print("Error fetching quotes: $e");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(milliseconds: 500),
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
      backgroundColor: const Color(0xFFEFEFEF), // 배경색 설정
      body: _matchEngine == null || _swipeItems.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SwipeCards(
              matchEngine: _matchEngine,
              itemBuilder: (BuildContext context, int index) {
                Quote quote = _swipeItems[index].content;
                return Card(
                  color: const Color(0xFFFFFFFF), // 카드 색상 설정
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          quote.message,
                          style:
                          Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          '- ${quote.author}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
              onStackFinished: () {
                _showSnackBar("No more quotes");
              },
              itemChanged: (SwipeItem item, int index) {
                print("Current quote: ${item.content.author}");
              },
              upSwipeAllowed: true,
              fillSpace: true,
            ),
          ),
        ],
      ),
    );
  }
}
