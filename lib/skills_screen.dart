import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'skill_card.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  List<dynamic> skills = [];

  @override
  void initState() {
    super.initState();
    loadSkills();
  }

  Future<void> loadSkills() async {
    final String response = await rootBundle.loadString(
      'assets/data/skills.json',
    );
    final data = json.decode(response);
    setState(() {
      skills = data;
    });
  }

  Widget buildSkillCarousel(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final skill = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SkillCard(name: skill['name'], image: skill['image']),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final basicSkills = skills
        .where((s) => s['level'] == "Basic")
        .toList()
        .cast<Map<String, dynamic>>();
    final intermediateSkills = skills
        .where((s) => s['level'] == "Intermediate")
        .toList()
        .cast<Map<String, dynamic>>();
    final advancedSkills = skills
        .where((s) => s['level'] == "Advanced")
        .toList()
        .cast<Map<String, dynamic>>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: skills.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 16,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Sports Skills",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    buildSkillCarousel("Basic", basicSkills),
                    buildSkillCarousel("Intermediate", intermediateSkills),
                    buildSkillCarousel("Advanced", advancedSkills),
                  ],
                ),
              ),
      ),
    );
  }
}
