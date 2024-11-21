import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchQuotes() async {
  try {
    // Make GET request to the local server
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/quotes'),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      return json.decode(response.body);
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any network or parsing errors
    throw Exception('Error fetching. : $e');
  }
}

// // Example usage in a widget or function
// void exampleUsage() async {
//   try {
//     List<dynamic> quotes = await fetchQuotes();
//     print(quotes); // Process the quotes as needed
//   } catch (e) {
//     print(e);
//   }
// }