

class HomeCategoryContents{
  String categoryName;
  List<Map<dynamic,dynamic>> contents;
  String description;
  String coverImage;
  String universityId;
  String title;
  List<dynamic> galleryImages;

  HomeCategoryContents({required this.categoryName, required this.contents,
    required this.description,required this.coverImage,required this.universityId,
    required this.title,required this.galleryImages});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'description': this.description,
      'coverImage': this.coverImage,
      'universityId': this.universityId,
      'title': this.title,
      'galleryImages': this.galleryImages,
    };
  }

  Map<String, dynamic> toMapDiger() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'coverImage': this.coverImage,
      'title': this.title,
      'galleryImages': this.galleryImages,

    };
  }

  factory HomeCategoryContents.fromMap(Map<dynamic, dynamic> map) {
    return HomeCategoryContents(
      categoryName: map['categoryName'],
      contents: map['contents'],
      description: map['description'],
      coverImage: map['image'],
      universityId: map['universityId'],
      title: map['title'],
      galleryImages: map['galeriImage'],

    );
  }
}

