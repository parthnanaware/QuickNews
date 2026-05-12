import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/article_model.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;
  const DetailsScreen({super.key, required this.article});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final WebViewController controller;
  bool _showWebView = false;

  @override
  void initState() {
    super.initState();
    // Initialize the webview controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.article.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.sourceName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _showWebView
          ? WebViewWidget(controller: controller) // Show full site inside the app
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.article.url,
              child: Image.network(
                widget.article.urlToImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Published at: ${widget.article.publishedAt.substring(0, 10)}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(height: 30),
                  Text(
                    widget.article.description,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  // This shows the snippet from NewsAPI
                  Text(
                    widget.article.content.split('[+')[0],
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 30),
                  // Professional "Read More" button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                      ),
                      onPressed: () {
                        setState(() {
                          _showWebView = true; // Switch to WebView
                        });
                      },
                      child: const Text("Read Full Article In-App", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}