import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.recipes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // TAHAP 14: Tampilan Error Handling yang lebih profesional dengan tombol Retry
          if (provider.errorMessage.isNotEmpty && provider.recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Gagal memuat data:\n${provider.errorMessage}', 
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => provider.fetchRecipes(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (provider.recipes.isEmpty) {
            return const Center(child: Text('Tidak ada resep ditemukan.'));
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchRecipes(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: provider.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = provider.recipes[index];
                      return RecipeCard(
                        mealId: recipe.idMeal,
                        title: recipe.strMeal,
                        category: 'Seafood',
                        imageUrl: recipe.strMealThumb,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: provider.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = provider.recipes[index];
                      return RecipeCard(
                        mealId: recipe.idMeal,
                        title: recipe.strMeal,
                        category: 'Seafood',
                        imageUrl: recipe.strMealThumb,
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}