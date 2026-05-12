class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String sourceName;
  final String publishedAt;
  final String content; // Add this line

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    required this.sourceName,
    required this.publishedAt,
    required this.content, // Add this line
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
      sourceName: json['source']?['name'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '', // Add this line
    );
  }
}