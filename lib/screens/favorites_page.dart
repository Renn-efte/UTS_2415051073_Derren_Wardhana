import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'recipe_form_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipe Box'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<RecipeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
          }
          if (provider.savedRecipes.isEmpty) {
            return const Center(
              child: Text('Belum ada resep yang disimpan.', style: TextStyle(fontSize: 16)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: provider.savedRecipes.length,
            itemBuilder: (context, index) {
              final saved = provider.savedRecipes[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                child: ListTile(
                  title: Text(saved.mealName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Status: ${saved.status} | Rating: ${saved.rating}/5\nCatatan: ${saved.note}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Buka form dengan melempar data existingRecipe
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeFormPage(
                                mealName: saved.mealName,
                                mealId: saved.mealId,
                                existingRecipe: saved, // Ini kuncinya!
                              ),
                            ),
                          );
                        },
                      ),
                     IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Tampilkan dialog konfirmasi sebelum menghapus
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Hapus Resep'),
                              content: Text('Yakin ingin menghapus ${saved.mealName} dari My Box?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx), // Tutup dialog
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx); // Tutup dialog dulu
                                    // Panggil fungsi delete dari Provider
                                    final success = await context.read<RecipeProvider>().deleteRecipe(saved.id!);
                                    
                                    if (success && context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Resep berhasil dihapus!'), backgroundColor: Colors.red),
                                      );
                                    }
                                  },
                                  child: const Text('Hapus', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}