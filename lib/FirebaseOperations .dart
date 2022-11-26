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
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getHomeCategories()async{
    var userDocument = await firestore.collection("homeCategories").get();
    print("--------------------------------- ${userDocument.docs[0]["title"]}");

    return userDocument.docs;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getContents()async{
    var contentMap = await firestore.collection("homeCategoryContent").get();

    return contentMap.docs;
  }


  ////////////////////////////benim kod/////////////////7

  Future<List> getPlaceUni({required String title}) async{
    var placeDocuments =await firestore.collection("homeCategoryContent").get();
    List result = [];
    for (var i in placeDocuments.docs){
      if(i.data()["title"] == title){
        result.add(i);
      }
    }
    return result;
  }
  Future<void> addData(HomeCategoryContents homeCategoryContents) async{
    await firestore.collection("homeCategoryContent").add(homeCategoryContents.toMap());
  }

  Future<List> getPlaceDiger({required String title}) async{
    var placeDocuments =await firestore.collection("homeCategoryDiger").get();
    List result = [];
    for (var i in placeDocuments.docs){
      if(i.data()["title"] == title){
        result.add(i);
      }
    }
    return result;
  }

  Future<void> addDiger(HomeCategoryContents homeCategoryContents) async{
    await firestore.collection("homeCategoryDiger").add(homeCategoryContents.toMapDiger());
  }




}