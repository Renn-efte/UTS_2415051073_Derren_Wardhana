class Recipe {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strMealThumb; // URL gambar resep

  Recipe({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strMealThumb,
  });

  // Factory untuk memetakan JSON API ke objek Dart
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
    );
  }
}