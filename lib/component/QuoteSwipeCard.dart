import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:quote_app/model/QuoteClass.dart';

class QuoteSwipeCard extends StatelessWidget {
  final List<SwipeItem> swipeItems;
  final MatchEngine matchEngine;
  final VoidCallback onStackFinished;

  const QuoteSwipeCard({
    Key? key,
    required this.swipeItems,
    required this.matchEngine,
    required this.onStackFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360, // 카드 컴포넌트의 폭
      height: 580, // 카드 컴포넌트의 높이
      child: SwipeCards(
        matchEngine: matchEngine,
        itemBuilder: _buildQuoteCard,
        onStackFinished: onStackFinished,
        itemChanged: (SwipeItem item, int index) {
          print("Current quote: ${item.content.author}");
        },
        upSwipeAllowed: true,
        fillSpace: true,
      ),
    );
  }

  Widget _buildQuoteCard(BuildContext context, int index) {
    Quote quote = swipeItems[index].content;
    return Card(
      color: Colors.white,
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
                fontWeight: FontWeight.w400,
                fontSize: 23.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              '${quote.author}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '"${quote.authorProfile}"',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}