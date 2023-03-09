import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_tanitim/SPOperations.dart';
import 'package:uni_tanitim/models/InitCategory.dart';
import 'models/Comment.dart';
import 'models/Content.dart';
import 'models/Category.dart';

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


  Future<List> getPlaceUni2({required String title}) async{
    var placeDocuments =await firestore.collection(title).get();
    print("  ************   ${title} DATA BROUGHT  ************ ");
    return placeDocuments.docs;
  }


  Future<void> addData2(Category homeCategoryContents, String collection) async{
    String yeniDataId = firestore.collection(collection).doc().id;
    var map = homeCategoryContents.toMap();
    map["categoryId"] =yeniDataId;  // adding categoryId
    await firestore.doc("${collection}/${yeniDataId}").set(map);
  }

  Future<void> addUserData(Map<String, dynamic> userData)async{
    await firestore.collection("userData").add(userData);

  }



  Future<void> updateLikes2(Comment comment)async{
    await firestore.doc("userComments/${comment.commentId}").update({"likes":comment.likes});
  }



  Future<void> addComments2(Comment comment) async{
    String commentId = firestore.collection("userComments").doc().id;
    var map =comment.toMap();
    map["commentId"] = commentId;
    await firestore.doc("userComments/${commentId}").set(map);
  }



  Future<List<Comment>> getComments2({required String placeId})async{
    print("place Id --------- ${placeId}");
    var commentsDocument =await firestore.collection("userComments").where("placeId", isEqualTo: placeId).get();
    List<Comment> commentsList = [];
    for(var i in commentsDocument.docs){
      bool likeStatus = await SPOperations.getLikeStatus(i["commentId"]) != true? false:true;
      commentsList.add(Comment.fromMap(i.data(),likeStatus));
    }
    return commentsList;
  }


}