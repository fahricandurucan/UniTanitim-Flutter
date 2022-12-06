import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AddingPage.dart';
import 'FirebaseOperations.dart';
import 'ImagesViewPage.dart';
import 'VideosViewPage.dart';
import 'widgets/contentWidget.dart';
import 'widgets/linkWidget.dart';

class ContentPage extends StatelessWidget {
  String categoryId;
  late List<dynamic> contents;
  late String coverImage;
  late String categoryName;
  late List<dynamic> galeriImage;

  ContentPage({required this.categoryId,required this.contents,required this.coverImage,required this.categoryName,required this.galeriImage}) ;


  FirebaseOperations firebaseOperations = FirebaseOperations();



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.black87,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Flexible(child: Text(categoryName, style: TextStyle(color: Colors.white, fontSize: 17),overflow: TextOverflow.fade,)),

                Container(
                  margin: EdgeInsets.only(top: 7,bottom: 7,left: 15),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1.5), borderRadius: BorderRadius.circular(12)) ,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(AddingPage(categoryId: categoryId, whichCategory: categoryName));
                    },
                    child: Row(
                      children: [
                        Text("Ekleme Yap ",style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w300)),
                        Icon(Icons.add, color: Colors.white,)
                      ],
                    ),
                  ) ,
                ),

              ],
            ),
          )
      ),
      backgroundColor: Color(0xffececec),
      body: ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    height:250,
                    width: width,
                    child:Image.network(coverImage,fit: BoxFit.cover,)),
                Row(
                  children: [
                    Flexible(child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VideosViewPage()));
                      },
                      child: Container(
                        height: 45,
                        color: Color(0x88cb0000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Videolar",style: TextStyle(fontSize: 17, decoration: TextDecoration.none, color: Colors.white)),
                            Icon(Icons.videocam_outlined,size: 25,)],),
                      ),
                    )
                    ),
                    Flexible(child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewPage(galeriImage: galeriImage,)));
                      },
                      child: Container(
                        height: 45,
                        color: Color(0x88cbb000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Resimler",style: TextStyle(fontSize: 17, decoration: TextDecoration.none, color: Colors.white)),
                            Icon(Icons.photo_camera_outlined,size: 25,)],),
                      ),
                    ),
                    ),
                  ],
                ),
              ],
            ),


            for(var content in contents)
              showContent(content)
          ]
      ),
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
