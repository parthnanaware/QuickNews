import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _currentCategory = 'general';

  final List<String> categories = ['general', 'business', 'technology', 'sports', 'entertainment'];

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get currentCategory => _currentCategory;

  NewsProvider() {
    fetchNews(); // Fetch initially
  }

  Future<void> fetchNews({String? category}) async {
    if (category != null) {
      _currentCategory = category;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _articles = await _newsService.fetchTopHeadlines(_currentCategory);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}