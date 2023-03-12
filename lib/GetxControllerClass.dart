import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/models/Category.dart';
import 'package:uni_tanitim/models/Comment.dart';

import 'SPOperations.dart';

class GetxControllerClass extends GetxController{

  var userImages= [].obs;
  var places = [].obs;
  RxList<Comment> comments = <Comment>[].obs;

  //commentPage
  var titleVisibility = false.obs;
  var likeCount=0;


  FirebaseOperations firebaseOperations = FirebaseOperations();
  @override
  void onInit() async{
    List images = await SPOperations.getUserImages();
    userImages.value = images;
    print("************* GET INIT WORKED ************");
    super.onInit();
  }
  
  Future<void> getPlacesGetX({required String title})async{
    List list = [];
    for (QueryDocumentSnapshot<Map> i in await firebaseOperations.getPlaceUni2(title: title)){
      list.add(Category.fromMap(i.data()));
    }
    places.value = list;
  }

  // Future<void> getCommentsGetX({required String placeId})async{
  //   List<Comment> commentList = await firebaseOperations.getComments2(placeId: placeId);
  //   comments.value = commentList;
  // }

  void updateComments(int index, Comment comment){
    comments[index] = comment;
  }


}