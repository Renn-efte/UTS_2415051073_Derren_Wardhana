import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'recipe_form_page.dart';

class RecipeDetailPage extends StatelessWidget {
  final String mealId;
  final String title;
  final String category;
  final String imageUrl;

  const RecipeDetailPage({
    super.key,
    required this.mealId,
    required this.title,
    required this.category,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: ApiService().getRecipeDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final displayThumb = (snapshot.data?['thumb'] ?? '').isNotEmpty 
              ? snapshot.data!['thumb']! 
              : imageUrl;
          
          final displayCategory = (snapshot.data?['category'] ?? '').isNotEmpty 
              ? snapshot.data!['category']! 
              : category;

          final displayInstructions = snapshot.data?['instructions'] ?? 'Gagal memuat instruksi masak.';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    displayThumb,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      color: Colors.orange.shade100,
                      child: const Icon(Icons.broken_image, size: 80, color: Colors.deepOrange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Kategori: $displayCategory', 
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Instruksi Memasak:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(
                  displayInstructions,
                  style: const TextStyle(fontSize: 16, height: 1.6),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 80),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeFormPage(
                mealName: title, 
                mealId: mealId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.bookmark_add),
        label: const Text('Simpan'),
      ),
    );
  }
}