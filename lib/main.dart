import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Wajib import ini
import 'providers/recipe_provider.dart';
import 'screens/main_screen.dart';

void main() async {
  // Wajib ditambahkan agar Supabase jalan sebelum UI dirender
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kqzmwlfimejhrpvedjhu.supabase.co', 
    publishableKey: 'sb_publishable_XCDc417zqS_XaFgyTxmAwA_C-wUBiPs', 
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeProvider()
        ..fetchRecipes()
        ..fetchSavedRecipes(), // Tambahkan baris ini
      child: const RecipeBoxApp(),
    ),
  );
}

class RecipeBoxApp extends StatelessWidget {
  const RecipeBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeBox UTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}