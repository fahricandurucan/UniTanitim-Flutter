class InitCategory{
  String categoryName;
  String categoryDesc;
  String categoryImage;
  String universityId;
  String subtitle;

  InitCategory(
      {required this.categoryName,
        required this.categoryDesc,
        required this.categoryImage,
        required this.universityId,
        required this.subtitle,
      });

  Map<String, dynamic> toMap() {
    return {
      'categoryName': this.categoryName,
      'categoryDesc': this.categoryDesc,
      'categoryImage': this.categoryImage,
      'universityId': this.universityId,
      'subtitle': this.subtitle,

    };
  }

  factory InitCategory.fromMap(Map<String, dynamic> map) {
    return InitCategory(
      categoryName: map['categoryName'] ,
      categoryDesc: map['categoryDesc'] ,
      categoryImage: map['categoryImage'] ,
      universityId: map['universityId'] ,
      subtitle: map['subtitle'] ,

    );
  }
}