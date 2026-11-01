import 'package:flutter/material.dart';

class UniversityBadge extends StatelessWidget {
  final String text;

  const UniversityBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50, 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text(
        text, 
        style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold),
      ),
    );
  }
}