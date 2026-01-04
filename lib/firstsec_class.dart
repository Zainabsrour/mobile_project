class FirstSectionClass {
  final String title;
  final String description;
  final String image;

  FirstSectionClass({
    required this.title,
    required this.description,
    required this.image,
  });

  factory FirstSectionClass.fromJson(Map<String, dynamic> json) {
    return FirstSectionClass(
      title: json['section_tittle'] ?? '',
      description: json['section_description'] ?? '',
      image: json['section_image'] ?? '',
    );
  }
}

