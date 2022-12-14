import 'dart:async';


import 'package:comment_box/comment/comment.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_tanitim/SharedPreferencesOperations.dart';

import 'package:uni_tanitim/models/Comments.dart';
import 'package:uni_tanitim/models/LikeCountProvider.dart';

import 'FirebaseOperations.dart';

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


  FirebaseOperations firestore = FirebaseOperations();

  void initState() {
    // TODO: implement initState
    super.initState();
    firestore.getComments(placeId: widget.placeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Yorumlar"),
      ),
      body: Container(
        child: CommentBox(

          child: FutureBuilder(
            future: firestore.getComments(placeId: widget.placeId),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return ListView(
                  children: [
                    for(var i in snapshot.data)
                      CommentWidget(comment: i["comment"], title: i["title"], date: i["date"],likes: i["likes"],commentId:i["commentId"]),
                  ],
                );
              }
              else{
                return Center(child: Text("ERROR"),);
              }
            },
          ),
          labelText: 'Yorum yaz...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              setState(() {
                Comment comment = Comment(comment: commentController.text, title: "kampüs", date: widget.currentTime, likes: 0, placeId: widget.placeId);
                firestore.addComments2(comment);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.deepPurpleAccent,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {

  late String comment;
  late String title;
  late String date;
  late int likes;
  late String commentId;


  CommentWidget({required this.comment,required this.title, required this.date,required this.likes,required this.commentId});



  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {

  FirebaseOperations firebaseOperations = FirebaseOperations();


  late List listem=[];

  bool state = false;

  late int temp  = widget.likes;
  @override



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Card(
          elevation: 3,
          shadowColor: Colors.grey,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.deepPurpleAccent,),
            title: Text(widget.title),
            subtitle: Text(widget.comment),
            trailing: FittedBox(
              child: Column(
                children: [
                  Text(widget.date),
                  Wrap(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Consumer<LikeCountProvider>(
                                builder: (context,likeCountNesne,child){
                                  return IconButton(
                                    onPressed: (){
                                      setState(() {
                                        if(likeCountNesne.boolState()){
                                          likeCountNesne.likeAzalt(temp);
                                          likeCountNesne.boolFalse();

                                        }
                                        else{
                                          likeCountNesne.likeArttir(temp);
                                          setCommentId(widget.commentId);
                                          likeCountNesne.boolTrue();
                                        }
                                        firebaseOperations.updateLikes(widget.commentId, state, widget.likes);
                                      });
                                    },
                                    icon: Icon(
                                        Icons.favorite
                                    ),
                                    color: likeCountNesne.boolState() ? Colors.pink : Colors.grey,
                                  );
                                }
                            ),
                            Consumer<LikeCountProvider>(
                                builder: (context,likeCountNesne,child){
                                  return Text("${likeCountNesne.likeOku(temp)}",style: TextStyle(fontSize: 18),);
                                }
                            ),
                          ],
                        ),
                        // child:LikeButton(
                        //   onTap: onLikeButtonTapped,
                        //   isLiked: isLiked ? true :false,
                        //   likeCount: widget.likes,
                        //   likeBuilder: (isTapped) {
                        //     return Icon(
                        //       Icons.favorite,
                        //       color:  isTapped ? Colors.pink : Colors.grey,
                        //
                        //     );
                        //   },
                        // ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
  


  Future<bool> onLikeButtonTapped(bool isLiked)async {
    FirebaseOperations firebaseOperations = FirebaseOperations();

    if(isLiked==false){
      listem.add(widget.commentId);
    }
    else{
      listem.remove(widget.commentId);
      
    }
    
    await setCommentId(widget.commentId);
    await getCommentId(widget.commentId);

    firebaseOperations.updateLikes(widget.commentId, isLiked, widget.likes);

    return !isLiked;
  }






}