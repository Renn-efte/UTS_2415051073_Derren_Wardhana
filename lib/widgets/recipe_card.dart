import 'package:flutter/material.dart';
import '../screens/recipe_detail_page.dart';

class RecipeCard extends StatelessWidget {
  final String mealId;
  final String title;
  final String category;
  final String imageUrl;

  const RecipeCard({
    super.key,
    required this.mealId,
    required this.title, 
    required this.category,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 60, height: 60, color: Colors.orange.shade100,
              child: const Icon(Icons.fastfood, color: Colors.deepOrange),
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(category),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(
                mealId: mealId,
                title: title,
                category: category,
                imageUrl: imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}