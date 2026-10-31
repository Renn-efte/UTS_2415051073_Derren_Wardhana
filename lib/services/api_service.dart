import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  // Base URL dari TheMealDB API
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Recipe>> fetchRecipes() async {
    try {
      // Kita ambil resep kategori Seafood sebagai awalan
      final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=Seafood'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List meals = data['meals'];
        
        // Parsing JSON ke Dart Model (Syarat UTS)
        return meals.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dari server API');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi jaringan.');
    }
  }
}