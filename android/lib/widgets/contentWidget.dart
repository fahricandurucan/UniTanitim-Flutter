import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            title!=""? Text(title!, style: TextStyle(fontSize: titleFontSize,  decoration: TextDecoration.none, color: Colors.black)):SizedBox(),
            Text(content, style: TextStyle(fontSize: 16,color: Colors.black87,  decoration: TextDecoration.none)),
            if(imageLink!="")
            Image.network(imageLink!)
        ],
      ),
    );
  }
}
