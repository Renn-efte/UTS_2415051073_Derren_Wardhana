import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/saved_recipe.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;

  // Mengambil data dari tabel saved_recipes
  Future<List<SavedRecipe>> getSavedRecipes() async {
    final data = await _supabase.from('saved_recipes').select().order('id');
    return (data as List).map((e) => SavedRecipe.fromJson(e)).toList();
  }
}