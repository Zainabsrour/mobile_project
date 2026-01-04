import 'package:flutter/material.dart';
import 'first_sec.dart';
import 'category.dart'; // 👈 استيراد الملف
import 'recommended_section.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              // ===== First Section =====
              FirstSection(),

              // ===== Categories Row =====
              CategoriesRow(),
              
               SizedBox(height: 28), 
              RecommendedSection(),
              // ===== باقي الصفحة (لاحقاً) =====
              SizedBox(height: 500),
            ],
          ),
        ),
      ),
    );
  }
}

