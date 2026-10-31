import 'package:flutter/material.dart';
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
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.orange.shade100,
                  child: const Icon(Icons.fastfood, size: 80, color: Colors.deepOrange),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Kategori: $category', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Nanti deskripsi lengkap dari API TheMealDB akan muncul di sini.', style: TextStyle(fontSize: 16)),
          ],
        ),
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