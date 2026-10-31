import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeFormPage extends StatefulWidget {
  final String mealName;
  final String mealId; 

  const RecipeFormPage({super.key, required this.mealName, required this.mealId});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>(); // Kunci validasi wajib UTS
  String _status = 'Plan to Cook';
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final newRecipe = SavedRecipe(
        mealId: widget.mealId,
        mealName: widget.mealName,
        status: _status,
        rating: int.parse(_ratingController.text),
        note: _noteController.text,
      );

      final success = await context.read<RecipeProvider>().addRecipe(newRecipe);

      if (success && mounted) {
        // Syarat UTS: SnackBar untuk user feedback
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resep berhasil disimpan!'), backgroundColor: Colors.green),
        );
        Navigator.pop(context); // Kembali ke detail resep
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simpan ke RecipeBox')),
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
                initialValue: _status,
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
                    : const Text('Simpan Data', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}