// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'firstsec_class.dart';

// const String baseImageUrl =
//     "https://hotnrqpzbwnniqjtkofu.supabase.co/storage/v1/object/public/imagesproject/";

// class FirstSection extends StatefulWidget {
//   const FirstSection({super.key});

//   @override
//   State<FirstSection> createState() => _FirstSectionState();
// }

// class _FirstSectionState extends State<FirstSection> {
//   FirstSectionClass? section;
//   bool loading = true;
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchSection();
//   }

//   Future<void> fetchSection() async {
//     try {
//       final response =
//           await http.get(Uri.parse("http://127.0.0.1:3000/section"));

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);

//         setState(() {
//           section = FirstSectionClass.fromJson(data);
//           loading = false;
//         });
//       } else {
//         setState(() {
//           hasError = true;
//           loading = false;
//         });
//       }
//     } catch (_) {
//       setState(() {
//         hasError = true;
//         loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (loading) {
//       return const Padding(
//         padding: EdgeInsets.all(20),
//         child: CircularProgressIndicator(),
//       );
//     }

//     if (hasError || section == null) {
//       return const Text("Failed to load section");
//     }

//     final imageUrl = baseImageUrl + section!.image;

//     return Padding(
//       // ⬅️ خففنا الـ bottom padding
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: Stack(
//           children: [
//             Image.network(
//               imageUrl,
//               height: 190,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//             Container(
//               height: 190,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.6),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 14,
//               right: 14,
//               bottom: 14,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     section!.title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     section!.description,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'firstsec_class.dart';

const String baseImageUrl =
    "https://hotnrqpzbwnniqjtkofu.supabase.co/storage/v1/object/public/imagesproject/";

class FirstSection extends StatefulWidget {
  const FirstSection({super.key});

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  FirstSectionClass? section;
  bool loading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchSection();
  }

  Future<void> fetchSection() async {
    try {
      final response =
          await http.get(Uri.parse("http://127.0.0.1:3000/section"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          section = FirstSectionClass.fromJson(data);
          loading = false;
        });
      } else {
        hasError = true;
        loading = false;
        setState(() {});
      }
    } catch (_) {
      hasError = true;
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      );
    }

    if (hasError || section == null) {
      return const Text("Failed to load section");
    }

    final imageUrl = baseImageUrl + section!.image;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Column(
        children: [
          // =======================
          // 🔍 SEARCH + ICONS (OUTSIDE IMAGE)
          // =======================
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Search furniture",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _TopIcon(icon: Icons.notifications_none),
              const SizedBox(width: 8),
              _TopIcon(icon: Icons.shopping_cart_outlined),
            ],
          ),

          const SizedBox(height: 14),

          // =======================
          // IMAGE CARD
          // =======================
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // Gradient
                Container(
                  height: 190,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // Text bottom
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        section!.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// ICON WIDGET
// =======================
class _TopIcon extends StatelessWidget {
  final IconData icon;

  const _TopIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}

