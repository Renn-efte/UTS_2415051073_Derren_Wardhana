import 'package:flutter/material.dart';
import '../widgets/profile_item.dart';
import '../widgets/university_badge.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text('Derren Wardhana', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            UniversityBadge(text: 'Salam Harmoni - Teknik Informatika'), // Custom Widget 2
            SizedBox(height: 32),
            Divider(),
            // Custom Widget 1 dipakai berulang (Reusable)
            ProfileItem(icon: Icons.badge, label: 'NIM', value: '2415051073'),
            ProfileItem(icon: Icons.class_, label: 'Kelas', value: 'PTI-5IKI'),
            ProfileItem(icon: Icons.email, label: 'Email', value: 'derren@student.undiksha.ac.id'),
            ProfileItem(icon: Icons.code, label: 'Tech Stack', value: 'Flutter, Provider, Supabase'),
          ],
        ),
      ),
    );
  }
}