class SavedRecipe {
  final int? id; // Primary key (diisi otomatis oleh Supabase)
  final String mealId;
  final String mealName;
  final String status; // 'Plan to Cook' atau 'Cooked'
  final int rating;
  final String note;

  SavedRecipe({
    this.id,
    required this.mealId,
    required this.mealName,
    required this.status,
    required this.rating,
    required this.note,
  });

  // Factory untuk menerima data (SELECT) dari database Supabase
  factory SavedRecipe.fromJson(Map<String, dynamic> json) {
    return SavedRecipe(
      id: json['id'],
      mealId: json['meal_id'] ?? '',
      mealName: json['meal_name'] ?? '',
      status: json['status'] ?? '',
      rating: json['rating'] ?? 0,
      note: json['note'] ?? '',
    );
  }

  // Mengubah objek Dart menjadi JSON untuk dikirim (INSERT/UPDATE) ke Supabase
  Map<String, dynamic> toJson() {
    return {
      // Baris id kita hapus karena dilarang diubah secara manual
      'meal_id': mealId,
      'meal_name': mealName,
      'status': status,
      'rating': rating,
      'note': note,
    };
  }
}