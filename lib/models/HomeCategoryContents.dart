
import 'Content.dart';

class HomeCategoryContents{
  String categoryName;
  List<Map<dynamic,dynamic>> contents;
  String description;
  String image;
  String universityId;
  String title;
  List<dynamic> galeriImage;

  HomeCategoryContents({required this.categoryName, required this.contents,
    required this.description,required this.image,required this.universityId,
    required this.title,required this.galeriImage});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'description': this.description,
      'image': this.image,
      'universityId': this.universityId,
      'title': this.title,
      'galeriImage': this.galeriImage,
    };
  }
  Map<String, dynamic> toMapDiger() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'image': this.image,
      'title': this.title,
      'galeriImage': this.galeriImage,

    };
  }

  factory HomeCategoryContents.fromMap(Map<dynamic, dynamic> map) {
    return HomeCategoryContents(
      categoryName: map['categoryName'],
      contents: map['contents'],
      description: map['description'],
      image: map['image'],
      universityId: map['universityId'],
      title: map['title'],
      galeriImage: map['galeriImage'],

    );
  }
}

