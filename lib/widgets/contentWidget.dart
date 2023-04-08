import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_tanitim/widgets/EShowUpText.dart';

class ContentWidget extends StatelessWidget {
  String? title;
  String content;
  String? imageLink;

  ContentWidget({this.title, required this.content, this.imageLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 12,bottom: 12),
      child: Column(
        children: [
            title!=""? Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 8),
                    child: Text(title!.substring(1), style: TextStyle(fontSize:20,  decoration: TextDecoration.none, color: Colors.black)),
                  ),
                ),
              ],
            ):SizedBox(),
            content!=""?EShowUpText(text: content): SizedBox(),
            if(imageLink!="")
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.network(imageLink!),
            )
        ],
      ),
    );
  }
}
