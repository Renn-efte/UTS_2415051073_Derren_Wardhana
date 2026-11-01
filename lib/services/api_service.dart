import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Recipe>> fetchRecipes() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/search.php?s='));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List meals = data['meals'] ?? [];
        return meals.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dari server API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi jaringan.');
    }
  }

  // TAHAP 15: Ambil detail lengkap (Instruksi, Gambar, Kategori) berdasarkan ID
  Future<Map<String, String>> getRecipeDetails(String mealId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$mealId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          final meal = data['meals'][0];
          return {
            'instructions': meal['strInstructions'] ?? 'Instruksi tidak tersedia.',
            'thumb': meal['strMealThumb'] ?? '',
            'category': meal['strCategory'] ?? 'Aneka Resep',
          };
        }
      }
      return {'instructions': 'Data gagal diproses.', 'thumb': '', 'category': ''};
    } catch (e) {
      return {'instructions': 'Gagal terhubung ke jaringan.', 'thumb': '', 'category': ''};
    }
  }
}