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
          if (provider.isLoading && provider.savedRecipes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // TAHAP 14: Error Handling UI untuk Supabase
          if (provider.errorMessage.isNotEmpty && provider.savedRecipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Ada masalah koneksi:\n${provider.errorMessage}', 
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => provider.fetchSavedRecipes(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Muat Ulang'),
                  ),
                ],
              ),
            );
          }

          if (provider.savedRecipes.isEmpty) {
            return const Center(
              child: Text('Belum ada resep yang disimpan.', style: TextStyle(fontSize: 16)),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchSavedRecipes(),
            child: ListView.builder(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeFormPage(
                                  mealName: saved.mealName,
                                  mealId: saved.mealId,
                                  existingRecipe: saved,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('Hapus Resep'),
                                content: Text('Yakin ingin menghapus ${saved.mealName} dari My Box?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(ctx);
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
            ),
          );
        },
      ),
    );
  }
}