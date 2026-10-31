import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeFormPage extends StatefulWidget {
  final String mealName;
  final String mealId;
  final SavedRecipe? existingRecipe; // Tambahan untuk mengecek apakah ini mode Edit

  const RecipeFormPage({
    super.key, 
    required this.mealName, 
    required this.mealId,
    this.existingRecipe,
  });

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _status = 'Plan to Cook';
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika ada data yang dilempar (Mode Edit), isi field secara otomatis
    if (widget.existingRecipe != null) {
      _status = widget.existingRecipe!.status;
      _ratingController.text = widget.existingRecipe!.rating.toString();
      _noteController.text = widget.existingRecipe!.note;
    }
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final isUpdating = widget.existingRecipe != null;
      
      final recipeData = SavedRecipe(
        id: isUpdating ? widget.existingRecipe!.id : null, // Pakai ID lama jika update
        mealId: widget.mealId,
        mealName: widget.mealName,
        status: _status,
        rating: int.parse(_ratingController.text),
        note: _noteController.text,
      );

      final provider = context.read<RecipeProvider>();
      final success = isUpdating 
          ? await provider.updateRecipe(recipeData) // Panggil Update
          : await provider.addRecipe(recipeData);   // Panggil Insert

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isUpdating ? 'Resep berhasil diupdate!' : 'Resep berhasil disimpan!'), 
            backgroundColor: Colors.green
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpdating = widget.existingRecipe != null;

    return Scaffold(
      appBar: AppBar(title: Text(isUpdating ? 'Edit RecipeBox' : 'Simpan ke RecipeBox')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.mealName,
                decoration: const InputDecoration(labelText: 'Nama Resep', border: OutlineInputBorder()),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status Masak', border: OutlineInputBorder()),
                items: ['Plan to Cook', 'Cooked'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => _status = newValue!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating (1-5)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Rating wajib diisi';
                  final rating = int.tryParse(value);
                  if (rating == null || rating < 1 || rating > 5) return 'Rating harus angka 1-5';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Catatan Modifikasi', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Catatan tidak boleh kosong';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: context.watch<RecipeProvider>().isLoading ? null : _saveData,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: context.watch<RecipeProvider>().isLoading 
                    ? const CircularProgressIndicator()
                    : Text(isUpdating ? 'Update Data' : 'Simpan Data', style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}