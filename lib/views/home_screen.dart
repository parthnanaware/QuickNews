import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../providers/news_provider.dart';
import '../widgets/news_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Very light grey background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Discover',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: -1,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCategoryChips(context),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<NewsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return _buildShimmerLoading();
                }

                if (provider.errorMessage.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('Something went wrong.\n${provider.errorMessage}', textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.fetchNews(),
                          child: const Text('Try Again'),
                        )
                      ],
                    ),
                  );
                }

                if (provider.articles.isEmpty) {
                  return const Center(child: Text('No articles found.'));
                }

                return RefreshIndicator(
                  onRefresh: () => provider.fetchNews(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.articles.length,
                    itemBuilder: (context, index) {
                      return NewsCard(article: provider.articles[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final category = provider.categories[index];
          final isSelected = provider.currentCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                category[0].toUpperCase() + category.substring(1),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              selected: isSelected,
              selectedColor: Colors.black,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onSelected: (selected) {
                if (selected && !provider.isLoading) {
                  provider.fetchNews(category: category);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 250,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}