class InitCategory{
  String categoryName;
  String categoryDesc;
  String categoryImage;
  String universityId;

  InitCategory(
      {required this.categoryName,
        required this.categoryDesc,
        required this.categoryImage,
        required this.universityId});

  Map<String, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'categoryDesc': this.categoryDesc,
      'categoryImage': this.categoryImage,
      'universityId': this.universityId,
    };
  }

  factory InitCategory.fromMap(Map<String, dynamic> map) {
    return InitCategory(
      categoryName: map['categoryName'] ,
      categoryDesc: map['categoryDesc'] ,
      categoryImage: map['categoryImage'] ,
      universityId: map['universityId'] ,
    );
  }
}