class InitCategory{
  String title;
  String description;
  String image;

  InitCategory({required this.title, required this.description, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'image': this.image,
    };
  }

  factory InitCategory.fromMap(Map<String, dynamic> map) {
    return InitCategory(
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }
}

