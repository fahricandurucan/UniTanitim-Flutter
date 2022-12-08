import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'FirebaseOperations.dart';

class CommentsPage extends StatefulWidget {

  late String placeId;
  CommentsPage({required this.placeId});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  FirebaseOperations firestore = FirebaseOperations();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Yorumlar"),
      ),
      body: FutureBuilder(
        future: firestore.getComments(placeId: widget.placeId),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView(
              children: [
                for(var i in snapshot.data)
                  CommentWidget(comment: i["comment"], title: i["title"], date: i["date"],),
              ],
            );
          }
          else{
            return Center(child: Text("ERROR"),);
          }
        },
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {

  late String comment;
  late String title;
  late String date;
  late int likes;

  CommentWidget({required this.comment,required this.title, required this.date});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
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
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.date),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
