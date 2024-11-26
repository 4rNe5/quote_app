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
      backgroundColor: Color(0xFFE3E3E3), // Changed background color to white
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _swipeItems.isEmpty
          ? const Center(child: Text("No quotes available"))
          : Center(
        child: SizedBox(
          width: 350, // 카드 컴포넌트의 폭
          height: 540, // 카드 컴포넌트의 높이
          child: SwipeCards(
            matchEngine: _matchEngine!,
            itemBuilder: (BuildContext context, int index) {
              Quote quote = _swipeItems[index].content;
              return Card(
                color: Colors.white, // Changed card color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        quote.message,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ), // Adjusted text style
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '- ${quote.author}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                          fontSize: 16.0,
                        ), // Adjusted text style
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '${quote.authorProfile}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                          fontSize: 16.0,
                        ), // Adjusted text style
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
      ),
    );
  }
}