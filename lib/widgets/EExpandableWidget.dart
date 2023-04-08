import 'package:flutter/material.dart';

import 'contentWidget.dart';
import 'linkWidget.dart';

class EExpandableWidget extends StatefulWidget {
  List items;  // List<List<Map>>
  EExpandableWidget(this.items);

  @override
  State<EExpandableWidget> createState() => _EExpandableWidgetState();
}
  int currentItem =-1;

List<Color> colorList = [
  Color(0x83e71f64),
  Color(0x839b27ae),
  Color(0x834051b4),
  Color(0x832396f4),
  Color(0x83019588),
  Color(0x838cc24c),
  Color(0x83FFCC00),
];


class _EExpandableWidgetState extends State<EExpandableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i=0; i<widget.items.length;i++)
         Column(
           children: [
             InkWell(
               onTap: (){
                 setState(() {
                   if(currentItem==i){
                     currentItem=-1;
                   }else{
                     currentItem = i;
                   }

                 });
               },
               child: Container(
                 height: 75,
                 width: double.infinity,
                 color: colorList[i%7],
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Flexible(child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 18.0),
                       child: Text(widget.items[i][0]["title"].substring(1),style: TextStyle(overflow: TextOverflow.fade, fontSize: 20,fontFamily: "K2D"),maxLines: 1,),
                     )),
                     Padding(
                         padding: const EdgeInsets.only(right: 25),
                         child: currentItem == i ?Icon(Icons.keyboard_arrow_down_rounded):Icon(Icons.keyboard_arrow_up_rounded))
                   ],
                 ),
               ),
             ),
             Visibility(
                 visible: currentItem == i,
                 child: Container(
                   //color: colorList[i%7].withOpacity(0.2),
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                       colors: [
                         colorList[i%7].withOpacity(0.2), // Start with opaque white
                         colorList[i%7].withOpacity(0), // End with transparent white
                       ],
                     ),
                   ),

                   child: Column(
                     children: [
                       for (Map contents in widget.items[i]) showContent(contents),
                     ],
                   ),
                 ),
               ),




           ],
         )
      ],
    );
  }

  Widget showContent(Map content){
    if(content["title"] !="link"){
      return  ContentWidget(content: content["content"],
        imageLink: content["image"] ,
        title: content["title"],);

    }else{
      return LinkWidget(link: content["content"], imageLink: content["image"]);
    }
  }


}
