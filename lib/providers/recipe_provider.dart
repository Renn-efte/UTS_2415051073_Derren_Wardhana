import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/saved_recipe.dart';
import '../services/api_service.dart'; // Import service  baru

class RecipeProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService(); // Instansiasi service

  List<Recipe> _recipes = [];
  List<SavedRecipe> _savedRecipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Recipe> get recipes => _recipes;
  List<SavedRecipe> get savedRecipes => _savedRecipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // TAHAP 8: Ambil data asli dari API
  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners(); // Tampilkan loading UI

    try {
      _recipes = await _apiService.fetchRecipes();
    } catch (e) {
      _errorMessage = e.toString(); // Tampilkan error UI
    } finally {
      _isLoading = false;
      notifyListeners(); // Sembunyikan loading UI
    }
  }

  // (Biarkan fetchSavedRecipes seperti sebelumnya untuk Tahap 9)
  Future<void> fetchSavedRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}