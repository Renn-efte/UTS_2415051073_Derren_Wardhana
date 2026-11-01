class Recipe {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory; // Tambahan untuk kategori dinamis

  Recipe({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strCategory: json['strCategory'], 
    );
  }
}