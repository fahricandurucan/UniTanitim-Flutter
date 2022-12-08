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
                  CommentWidget(),
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

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.blue,


    );
  }
}
