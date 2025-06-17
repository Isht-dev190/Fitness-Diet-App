import 'package:app_dev_fitness_diet/frontend/core/Models/article_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_dev_fitness_diet/frontend/core/theme/app_pallete.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/tips_viewModel.dart';
import 'package:app_dev_fitness_diet/frontend/features/Tips/article_details_view.dart';

class TipsView extends StatelessWidget {
  const TipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TipsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(viewModel.error!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.refreshArticles,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    onChanged: viewModel.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search articles...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppPallete.primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppPallete.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: AppPallete.primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('Liked'),
                          selected: viewModel.showLikedOnly,
                          onSelected: (_) => viewModel.toggleShowLikedOnly(),
                          selectedColor: AppPallete.primaryColor.withOpacity(0.2),
                          checkmarkColor: AppPallete.primaryColor,
                          labelStyle: TextStyle(
                            color: viewModel.showLikedOnly ? Colors.white : null,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...viewModel.categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: FilterChip(
                              label: Text(category),
                              selected: viewModel.selectedCategory == category,
                              onSelected: (_) => viewModel.updateSelectedCategory(category),
                              selectedColor: AppPallete.primaryColor,
                              checkmarkColor: Colors.white,
                              labelStyle: TextStyle(
                                color: viewModel.selectedCategory == category ? Colors.white : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: viewModel.articles.length,
                itemBuilder: (context, index) {
                  final article = viewModel.articles[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: AppPallete.primaryColor),
                    ),
                    elevation: 4,
                    shadowColor: AppPallete.primaryColor.withOpacity(0.3),
                    child: GestureDetector(
                      onTap: () => _showArticleDetails(context, article),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    article.isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: article.isLiked ? AppPallete.primaryColor : null,
                                  ),
                                  onPressed: () => viewModel.toggleLike(article.id),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Chip(
                                  label: Text(article.category),
                                  backgroundColor: AppPallete.primaryColor.withOpacity(0.1),
                                  labelStyle: const TextStyle(color: AppPallete.primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: AppPallete.primaryColor.withOpacity(0.3)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  article.date,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _showArticleDetails(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailsView(article: article),
      ),
    );
  }
}