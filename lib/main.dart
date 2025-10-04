import 'package:flutter/material.dart';
import 'skills_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sports Skills',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SkillsScreen(),
    );
  }
}
 