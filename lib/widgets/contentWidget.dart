import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  String? title;
  String content;
  String? imageLink;
  double titleFontSize;

  ContentWidget({this.title, required this.content, this.imageLink, this.titleFontSize=18});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 12),
      child: Column(
        children: [
          Row(children: [Text(title??"", style: TextStyle(fontSize: titleFontSize,  decoration: TextDecoration.none, color: Colors.black)),],),
          SizedBox(height: 8,),
          Text(content, style: TextStyle(fontSize: 16,color: Colors.black87,  decoration: TextDecoration.none)),
          SizedBox(height: 10,),
          if(imageLink!=null)
            Image.network(imageLink!)
        ],
      ),
    );
  }
}