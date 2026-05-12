import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService {
  static const String _apiKey = 'e8cf3aac683e46bcbc9d256f16dbe7ff';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  Future<List<Article>> fetchTopHeadlines(String category) async {
    final url = Uri.parse('$_baseUrl?country=us&category=$category&apiKey=$_apiKey');

    try {
      // Added headers because NewsAPI sometimes rejects requests without a User-Agent
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'QuickNewsApp/1.0',
          'Accept': 'application/json',
        },
      );

      // DEBUG PRINTS: Check your VS Code / Android Studio Console!
      print('--- API DEBUG ---');
      print('URL: $url');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List<dynamic> articlesJson = data['articles'];

          return articlesJson
              .map((json) => Article.fromJson(json))
              .where((article) =>
          article.urlToImage.isNotEmpty &&
              article.title != '[Removed]' &&
              !article.urlToImage.contains('placeholder'))
              .toList();
        } else {
          print('API Error Message: ${data['message']}');
          throw Exception(data['message'] ?? 'Failed to load news');
        }
      } else {
        // If status is 401, this print will tell us exactly why
        print('Server Error Body: ${response.body}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Catch Error: $e');
      throw Exception('Network error: $e');
    }
  }
}