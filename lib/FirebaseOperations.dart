import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/Comments.dart';
import 'models/Content.dart';
import 'models/HomeCategoryContents.dart';
import 'models/InitCategory.dart';

class FirebaseOperations{

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getHomeCategories()async{
    var userDocument = await firestore.collection("homeCategories").get();

    return userDocument.docs;
  }

  Future<void> insertCategory({required String title, required String description, required String image}) async{
    InitCategory category = InitCategory(title: title, description: description, image: image);
    await firestore.collection("homeCategories").add(category.toMap());
  }




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

  Future<void> updateLikes(String commentId,bool isLiked,int likes)async{
    print("if den önce ${commentId}  ${isLiked}  ${likes}");
    if(!isLiked){
      likes = likes + 1;
    }


    print("if den sonra ${commentId}  ${isLiked}  ${likes}");

    await firestore.doc("userComments/${commentId}").update({"likes":likes});
  }

  Future<void> addComments({required Comment comment}) async{
    await firestore.collection("userComments").add(comment.toMap());
  }
  Future<void> addComments2(Comment comment) async{
    String commentId = firestore.collection("userComments").doc().id;
    var map =comment.toMap();
    map["commentId"] = commentId;
    await firestore.doc("userComments/${commentId}").set(map);
  }

  Future<List> getComments({required String placeId})async{
    var commentsDocument = await firestore.collection("userComments").get();
    List commentsList = [];
    for(var i in commentsDocument.docs){
      if(i.data()["placeId"]==placeId){
        commentsList.add(i);
        print("placeId --------------- > ${i["placeId"]}");
      }
    }
    return commentsList;
  }

  Future<void> addData(HomeCategoryContents homeCategoryContents) async{
    String yeniDataId = firestore.collection("homeCategoryContent").doc().id;
    var map = homeCategoryContents.toMap();
    map["categoryId"] =yeniDataId;  // adding categoryId
    await firestore.doc("homeCategoryContent/${yeniDataId}").set(map);
  }

  Future<void> updateGallery(String categoryId, String imageLink)async{
    await firestore.doc("homeCategoryContent/${categoryId}").update({"galleryImages.1" :imageLink});
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