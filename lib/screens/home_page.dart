import 'package:flutter/material.dart';
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
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 5, // Data dummy sementara
        itemBuilder: (context, index) {
          return RecipeCard(
            title: 'Resep Rahasia Krabby Patty ${index + 1}', 
            category: 'Seafood',
          );
        },
      ),
    );
  }
}