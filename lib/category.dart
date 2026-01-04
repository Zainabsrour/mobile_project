import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category_class.dart';
import 'product.dart'; 

const String baseApiUrl =
    "https://mobile-project-1-hfjv.onrender.com";

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({super.key});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  List<Category> categories = [];
  bool loading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get( Uri.parse(
  "$baseApiUrl/category"));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          categories =
              data.map((e) => Category.fromMap(e)).toList();
          loading = false;
        });
      } else {
        setState(() {
          hasError = true;
          loading = false;
        });
      }
    } catch (_) {
      setState(() {
        hasError = true;
        loading = false;
      });
    }
  }

  IconData _getIcon(String name) {
    final icons = <String, IconData>{
      'chairs': Icons.chair_alt,
      'tables': Icons.table_restaurant,
      'sofa': Icons.weekend,
      'decor': Icons.auto_awesome,
    };

    return icons[name.trim().toLowerCase()] ?? Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: CircularProgressIndicator(),
      );
    }

    if (hasError) {
      return const Text("Failed to load categories");
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: SizedBox(
        height: 86,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final category = categories[index];

            return InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                //  NAVIGATION
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductsPage(
                       categoryId: category.id,
                      categoryName: category.name,
                    ),
                  ),
                );
              },
              child: CategoryItem(
                icon: _getIcon(category.name),
                label: category.name,
              ),
            );
          },
        ),
      ),
    );
  }
}


// UI Item

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.green.shade400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}





