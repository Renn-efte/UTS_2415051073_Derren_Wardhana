import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/saved_recipe.dart';

class RecipeProvider extends ChangeNotifier {
  // State variables wajib UTS
  List<Recipe> _recipes = [];
  List<SavedRecipe> _savedRecipes = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters agar UI bisa membaca data
  List<Recipe> get recipes => _recipes;
  List<SavedRecipe> get savedRecipes => _savedRecipes;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Kerangka method untuk mengambil data dari API (akan diisi di Tahap 8)
  Future<void> fetchRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners(); // Memberitahu UI untuk menampilkan loading screen

    try {
      // TODO: Ambil data dari REST API TheMealDB
      await Future.delayed(const Duration(seconds: 1)); // Simulasi loading sementara
    } catch (e) {
      _errorMessage = 'Gagal memuat resep: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners(); // Memberitahu UI bahwa proses selesai
    }
  }

  // Kerangka method untuk mengambil data dari Supabase (akan diisi di Tahap 9)
  Future<void> fetchSavedRecipes() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // TODO: Ambil data dari Supabase
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      _errorMessage = 'Gagal memuat kotak resep: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}