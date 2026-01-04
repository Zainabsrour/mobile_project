import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'product_class.dart';

const String baseImageUrl =
    "https://hotnrqpzbwnniqjtkofu.supabase.co/storage/v1/object/public/imagesproject/";

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key});

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  List<Product> products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchRecommended();
  }

  // =======================
  // FETCH RANDOM PRODUCTS
  // =======================
  Future<void> fetchRecommended() async {
    final response =
        await http.get(Uri.parse("http://127.0.0.1:3000/products_random"));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      data.shuffle(); // 🔀 random

      setState(() {
        products = data.take(5).map((e) => Product.fromMap(e)).toList();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =======================
          // TITLE
          // =======================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Recommended for you",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // =======================
          // GRID (2 PER ROW)
          // =======================
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // ✅ 2 per row
              crossAxisSpacing: 14,
              mainAxisSpacing: 16,
              childAspectRatio: 0.72, // نفس شكل الصورة
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return _RecommendedCard(product: product);
            },
          ),
        ],
      ),
    );
  }
}

// =======================
// PRODUCT CARD
// =======================
class _RecommendedCard extends StatelessWidget {
  final Product product;

  const _RecommendedCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // IMAGE + HEART
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                baseImageUrl + product.image,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // NAME
        Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 4),

        // PRICE
        Text(
          product.price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
