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
      // TAHAP 4: Menggunakan LayoutBuilder untuk 2 kondisi layout
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tampilan Lebar (Expanded) -> Berubah jadi GridView 2 kolom
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                childAspectRatio: 3, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 5,
              itemBuilder: (context, index) => RecipeCard(
                title: 'Resep Rahasia Krabby Patty ${index + 1}',
                category: 'Seafood',
              ),
            );
          } else {
            // Tampilan Sempit (Compact/HP) -> Tetap ListView
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 5,
              itemBuilder: (context, index) => RecipeCard(
                title: 'Resep Rahasia Krabby Patty ${index + 1}',
                category: 'Seafood',
              ),
            );
          }
        },
      ),
    );
  }
}