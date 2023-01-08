import 'package:uni_tanitim/models/Content.dart';

class Category{
  String categoryId;//
  String categoryName;//
  List contents;//
  String coverImage;//
  String description;//
  List<dynamic> galleryImages;//
  List<dynamic> videos;//
  String universityId;
  int isOther;

  Category({required this.categoryId, required this.categoryName,
    required this.contents,required this.coverImage,required this.description,
    required this.galleryImages,required this.universityId, required this.isOther,
    required this.videos
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': this.categoryId,
      'categoryName': this.categoryName,
      'contents': this.contents,
      'coverImage': this.coverImage,
      'description': this.description,
      'galleryImages': this.galleryImages,
      'videos': this.videos,
      'universityId': this.universityId,
      'isOther': this.isOther,
    };
  }

  factory Category.fromMap(Map<dynamic, dynamic> map) {
    return Category(
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      contents: map['contents'] as List,
      coverImage: map['coverImage'] as String,
      description: map['description'] as String,
      galleryImages: map['galleryImages'] as List<dynamic>,
      videos: map['videos'] as List<dynamic>,
      universityId: map['universityId'] as String,
      isOther: map['isOther'] as int,
    );
  }
}


