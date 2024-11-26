import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:quote_app/model/QuoteClass.dart';

// 수정된 fetchQuotes 함수
Future<List<Quote>> fetchQuotes() async {
  try {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/quotes'),
    );

    if (response.statusCode == 200) {
      String utf8Decoded = utf8.decode(response.bodyBytes);
      List<dynamic> jsonList = json.decode(utf8Decoded);

      List<Quote> quotes = jsonList.map((json) => Quote.fromJson(json)).toList();

      // 개발자 로그 사용 (색상, 이모지 포함)
      for (var quote in quotes) {
        developer.log(
            '📜 Quote Details',
            name: '✨ QuoteApp',
            error: {
              '👤 Author': quote.author,
              '📋 Profile': quote.authorProfile,
              '💬 Message': quote.message
            }
        );
      }

      return quotes;
    } else {
      throw Exception('Failed to load quotes. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching quotes: $e');
  }
}