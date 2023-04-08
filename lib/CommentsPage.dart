import 'dart:async';
import 'dart:ui';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:uni_tanitim/widgets/commentWidget2.dart';

import 'FirebaseOperations.dart';
import 'GetxControllerClass.dart';
import 'SPOperations.dart';
import 'models/Comment.dart';

class CommentsPage extends StatefulWidget {




  late String placeId;
  CommentsPage({required this.placeId});


  var currentTime = DateFormat('dd-MM-yyyy').format(DateTime.now());



  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late FocusNode commentFocus;
  final commentEditTextController = TextEditingController();
  late FocusNode titleFocus;
  final titleEditTextController = TextEditingController();
  var TextFormFieldKey = GlobalKey();



  GetxControllerClass getxController = Get.put(GetxControllerClass());

  @override
  void dispose() {
    commentFocus.dispose();
    titleFocus.dispose();
    super.dispose();
  }


  FirebaseOperations firestore = FirebaseOperations();

  void initState() {
    commentFocus = FocusNode();
    titleFocus = FocusNode();
    getCommentsPaginated(placeId: widget.placeId);



    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        getCommentsPaginated(placeId: widget.placeId);
      }
    });

    //firestore.getComments2(placeId: widget.placeId);
    super.initState();
  }


  DocumentSnapshot? lastDocument;
  bool moreData = true;
  bool loadingData = false;
  final ScrollController scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return WillPopScope(
      onWillPop: ()async{
        getxController.comments.clear();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: Text("Yorumlar"),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
            getxController.titleVisibility.value = false;
            print("kland");
          },

          child: Obx(()=> ListView(
            controller: scrollController,
            children: [
              for(var c in getxController.comments)
                CommentWidget2(comment:c),
              loadingData?Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:20),
                  child: SimpleCircularProgressBar(
                    mergeMode: true,
                    animationDuration: 1,
                    size: 35,
                    progressStrokeWidth: 4,
                    backColor: Colors.transparent,
                    progressColors: const [Colors.cyan, Colors.purple]),
                ),

              )
                  :SizedBox(),
              SizedBox(height: 200,),
            ],
          ),)
        ),

        floatingActionButton: Padding(
          padding: isKeyboardOpen
              ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
              : const EdgeInsets.all(1.0),
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            padding: EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(()=>Visibility(
                  visible: getxController.titleVisibility.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      height: 30,
                      child: TextField(
                        focusNode: titleFocus,
                        controller: titleEditTextController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Başlık ya da Adın",
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ),
                ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTap: (){
                          getxController.titleVisibility.value=true;
                        },
                        focusNode: commentFocus,
                        controller: commentController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: (){
                                if(commentController.text!=""){
                                  Comment comment = Comment(comment: commentController.text, title: titleEditTextController.text,
                                      date: widget.currentTime, likes: 0, placeId: widget.placeId, commentId: "null", isLiked: false);
                                  firestore.addComments2(comment);
                                  Get.snackbar(
                                      "Yorum Gönderildi",
                                      "",
                                    messageText: Text("Kısa süre içerisinde yayınlanacaktır.",style: TextStyle(fontFamily: "Quicksand", color: Colors.white, fontSize: 15)),
                                    colorText: Colors.white,
                                    backgroundColor: Color(0xae000000),);

                                    commentController.clear();
                                    titleEditTextController.clear();
                                    FocusScope.of(context).unfocus();
                                    getxController.titleVisibility.value = false;
                                }

                              },
                              child: Icon(Icons.send_rounded)),
                          contentPadding: EdgeInsets.all(8),
                          hintText: "Yorum Yaz",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
        ,
      ),
    );



  }








  Future<void> getCommentsPaginated({required String placeId})async{

    if(moreData){
      setState(() {
        loadingData = true;
      });
      late var querySnapshot;

      final collectionReference = firestore.firestore.collection("userComments").where("placeId", isEqualTo: placeId);

      if(lastDocument == null){
        querySnapshot =await collectionReference.limit(6).get();
      }else{
        querySnapshot = await collectionReference.limit(6).startAfterDocument(lastDocument!).get();
      }


      if(querySnapshot.docs.length>0){
        lastDocument = querySnapshot.docs.last;
        int count = 0;
        // for(var i in querySnapshot.docs){
        //   bool likeStatus = await SPOperations.getLikeStatus(i["commentId"]) != true? false:true;
        //   //commentList.add(Comment.fromMap(i.data(),likeStatus));
        //   getxController.comments.add(Comment.fromMap(i.data(),likeStatus));
        //   count++;
        // }
        Timer(Duration(seconds: 1), () async{
          for(var i in querySnapshot.docs){
            bool likeStatus = await SPOperations.getLikeStatus(i["commentId"]) != true? false:true;
            getxController.comments.add(Comment.fromMap(i.data(),likeStatus));
            count++;
          }
          setState(() {
            loadingData =false;
            print("place Id --------- ${placeId} comment count : ${count}");
          });
        });

        print("length of list --------- ${getxController.comments.length} ");

        if(querySnapshot.docs.length < 6){
          moreData = false;
        }

      }else{
        setState(() {
          print("No Data");
          loadingData =false;
        });

      }

    }


  }
}








