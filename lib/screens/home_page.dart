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
          // 1. Handle Loading State
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Handle Error State
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
          }
          // 3. Handle Empty State
          if (provider.recipes.isEmpty) {
            return const Center(child: Text('Tidak ada resep ditemukan.'));
          }

          // 4. Data Ready State (Tampilkan data asli)
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Tampilan Sempit Grid
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: provider.recipes.length, // Sesuai jumlah data API
                  itemBuilder: (context, index) {
                    final recipe = provider.recipes[index];
                    return RecipeCard(
                      title: recipe.strMeal, // Judul asli dari API
                      category: 'Seafood', 
                    );
                  },
                );
              } else {
                // Tampilan List (HP)
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: provider.recipes.length, // Sesuai jumlah data API
                  itemBuilder: (context, index) {
                    final recipe = provider.recipes[index];
                    return RecipeCard(
                      title: recipe.strMeal, // Judul asli dari API
                      category: 'Seafood',
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}