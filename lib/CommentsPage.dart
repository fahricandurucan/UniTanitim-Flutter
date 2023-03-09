import 'dart:async';


import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    //firestore.getComments2(placeId: widget.placeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return WillPopScope(
      onWillPop: ()async{
        print(" ıu gıug ıytfıyfıyftfd");
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

          child: Obx(()=>ListView(
            children: [
              for(var c in getxController.comments)
                CommentWidget2(comment:c),
              SizedBox(height: 70,),
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
}








