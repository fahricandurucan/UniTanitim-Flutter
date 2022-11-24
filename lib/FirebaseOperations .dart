import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_tanitim/models/InitCategory.dart';

import 'models/HomeCategoryContents.dart';

class FirebaseOperations{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getInitCategories()async{
    var userDocument = await firestore.collection("initCategories").get();
    print(userDocument.docs[0]["categoryDesc"]);
    return userDocument.docs;
  }

  Future<void> insertCategory(String categoryDesc, String categoryImage, String categoryName, String universityId) async{
    InitCategory category = InitCategory(categoryName: categoryName, categoryDesc: categoryDesc, categoryImage: categoryImage, universityId: universityId);
    await firestore.collection("initCategories").add(category.toMap());
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getContents()async{
    var contentMap = await firestore.collection("homeCategoryContent").get();


    return contentMap.docs;
  }


  ////////////////////////////benim kod/////////////////7

  Future<List<QueryDocumentSnapshot<Map<dynamic, dynamic>>>> getPlaceUni() async{
    var placeDocuments =await firestore.collection("homeCategoryContent").get();
    return placeDocuments.docs;
  }


  // Future<void> addData(HomeCategoryContents homeCategoryContents) async{
  //   await firestore.collection("homeCategoryContent").add(homeCategoryContents.toMap());
  // }

}