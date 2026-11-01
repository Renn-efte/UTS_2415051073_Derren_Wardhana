import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_recipe.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  Future<List<SavedRecipe>> getSavedRecipes() async {
    final data = await _supabase.from('saved_recipes').select().order('id');
    return (data as List).map((e) => SavedRecipe.fromJson(e)).toList();
  }

  Future<void> addRecipe(SavedRecipe recipe) async {
    await _supabase.from('saved_recipes').insert(recipe.toJson());
  }

  // TAHAP 11: Fungsi UPDATE data
  Future<void> updateRecipe(SavedRecipe recipe) async {
    if (recipe.id == null) return;
    await _supabase
        .from('saved_recipes')
        .update(recipe.toJson())
        .eq('id', recipe.id!); // Cari baris yang ID-nya cocok lalu update
  }

  // TAHAP 12: Fungsi DELETE data
  Future<void> deleteRecipe(int id) async {
    await _supabase
        .from('saved_recipes')
        .delete()
        .eq('id', id); // Hapus baris yang ID-nya cocok
  }
}