import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_tanitim/SPOperations.dart';
import '../FirebaseOperations.dart';
import '../GetxControllerClass.dart';
import '../models/Comment.dart';


class CommentWidget2 extends StatelessWidget {

  Comment comment;
  CommentWidget2({required this.comment});


  FirebaseOperations firebaseOperations = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());
 // GetxControllerClass getxController = Get.find();



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: 8, right: 8),
      padding:EdgeInsets.all(8),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0, top: 8.0),
                child: Icon(Icons.account_circle_rounded, size: 50,color: Colors.green,),
              ),
            ],
          ),
          Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
                        child: Text(comment.title,style: TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Text(comment.date,style: TextStyle(fontFamily: "Quicksand", color: Colors.black54)),
                    ],
                  ),
                  Text(
                    comment.comment,
                    style: TextStyle(fontFamily: "Quicksand"),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: ()async{
                          // getxController.comments.value.removeAt(0);
                          bool likeStatus = await SPOperations.getLikeStatus(comment.commentId);
                          if(likeStatus ==null || likeStatus ==false){
                            comment.likes +=1;
                            comment.isLiked=true;
                            await SPOperations.setLikeStatus(comment.commentId, true);
                            await firebaseOperations.updateLikes2(comment);
                            getxController.updateComments(getxController.comments.value.indexOf(comment), comment);
                            // await firebaseOperations.updateLikes(comment.commentId, true, comment.likes);

                          }else{
                            comment.likes -=1;
                            comment.isLiked=false;
                            await firebaseOperations.updateLikes2(comment);
                            await SPOperations.setLikeStatus(comment.commentId, false);
                            getxController.updateComments(getxController.comments.value.indexOf(comment), comment);
                            //firebaseOperations.updateLikes(comment.commentId, false, comment.likes);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: comment.isLiked? Icon(Icons.favorite, size: 20,color: Colors.red,): Icon(Icons.favorite_border_rounded, size: 20,) ,
                        ),
                      ),
                      Text(comment.likes.toString(), style: TextStyle(fontFamily: "Quicksand", fontWeight: FontWeight.bold,color: Colors.black54),)
                    ],
                  )
                ],
              )),

        ],
      ) ,

    );
  }


}
