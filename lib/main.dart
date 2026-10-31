import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Tambahkan import ini
import 'providers/recipe_provider.dart'; // Tambahkan import ini
import 'screens/main_screen.dart';

void main() {
  runApp(
    // Bungkus aplikasi dengan Provider
    ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
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