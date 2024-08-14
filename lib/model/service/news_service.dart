import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '6d8a6c88e3454e1a8f7df2f07ae19698';
  final String apiUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<dynamic>> fetchNews(String category) async {
    final response = await http.get(Uri.parse('$apiUrl?category=$category&apiKey=$apiKey&country=us'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
