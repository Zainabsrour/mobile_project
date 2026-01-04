class Product {
  final int id;
  final String name;
  final double rate;
  final String price;
  final String image;
  final String description;
  final int categoryId;

  Product({
    required this.id,
    required this.name,
    required this.rate,
    required this.price,
    required this.image,
    required this.description,
    required this.categoryId,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      rate: (map['rate'] as num).toDouble(),
      price: map['price'],
      image: map['image'],
      description: map['description'],
      categoryId: map['category_id'],
    );
  }
}

