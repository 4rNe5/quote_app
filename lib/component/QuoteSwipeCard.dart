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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
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
              ),
            ),
            Divider(height: 4, thickness: 2, color: Color(0xFF7C7C7C),),
            SizedBox(height: 25.0),
            Text(
              '${quote.author}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '"${quote.authorProfile}"',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(
                fontWeight: FontWeight.w200,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}