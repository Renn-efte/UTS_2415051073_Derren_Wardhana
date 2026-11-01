import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/saved_recipe.dart';
import '../services/api_service.dart';
import '../services/supabase_service.dart'; // Import service baru

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final SupabaseService _dbService = SupabaseService(); // Daftarkan service Supabase

  List<Recipe> _recipes = [];
  List<SavedRecipe> _savedRecipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe> get recipes => _recipes;
  List<SavedRecipe> get savedRecipes => _savedRecipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      _recipes = await _apiService.fetchRecipes();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // TAHAP 9: Fungsi menarik data database yang sebenarnya
  Future<void> fetchSavedRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      _savedRecipes = await _dbService.getSavedRecipes();
    } catch (e) {
      _errorMessage = 'Gagal memuat kotak resep: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // TAHAP 10: Proses penambahan data dengan state management
  Future<bool> addRecipe(SavedRecipe recipe) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _dbService.addRecipe(recipe);
      await fetchSavedRecipes(); // Refresh data My Box secara otomatis
      return true; // Berhasil
    } catch (e) {
      _errorMessage = 'Gagal menyimpan resep: ${e.toString()}';
      return false; // Gagal
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // TAHAP 11: Proses update data dengan state management
  Future<bool> updateRecipe(SavedRecipe recipe) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _dbService.updateRecipe(recipe);
      await fetchSavedRecipes(); // Refresh daftar otomatis
      return true; 
    } catch (e) {
      _errorMessage = 'Gagal mengupdate resep: ${e.toString()}';
      return false; 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // TAHAP 12: Proses hapus data dengan state management
  Future<bool> deleteRecipe(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _dbService.deleteRecipe(id);
      await fetchSavedRecipes(); // Refresh daftar otomatis setelah dihapus
      return true; 
    } catch (e) {
      _errorMessage = 'Gagal menghapus resep: ${e.toString()}';
      return false; 
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}