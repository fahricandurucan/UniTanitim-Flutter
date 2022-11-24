
import 'Content.dart';

class HomeCategoryContents{
  String categoryName;
  List<Map<dynamic,dynamic>> contents;
  String description;
  String image;
  String universityId;

  HomeCategoryContents({required this.categoryName, required this.contents,
    required this.description,required this.image,required this.universityId});

  Map<dynamic, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'contents': this.contents,
      'description': this.description,
      'image': this.image,
      'universityId': this.universityId,
    };
  }

  factory HomeCategoryContents.fromMap(Map<dynamic, dynamic> map) {
    return HomeCategoryContents(
      categoryName: map['categoryName'],
      contents: map['contents'],
      description: map['description'],
      image: map['image'],
      universityId: map['universityId'],
    );
  }
}

