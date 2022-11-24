import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/ImagesViewPage.dart';
import 'package:uni_tanitim/VideosViewPage.dart';
import 'package:uni_tanitim/models/Content.dart';
import 'package:uni_tanitim/widgets/contentWidget.dart';

import 'FirebaseOperations .dart';

class ContentPage extends StatelessWidget {
  late   List<dynamic> contents;

  ContentPage({required this.contents});


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

                Flexible(child: Text(contents[0]["image"], style: TextStyle(color: Colors.white, fontSize: 17),overflow: TextOverflow.fade,)),

                Container(
                  margin: EdgeInsets.only(top: 7,bottom: 7,left: 15),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1.5), borderRadius: BorderRadius.circular(12)) ,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: (){
                      print(firebaseOperations.getContents());
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
                          child:Image.network(contents[0]["image"],fit: BoxFit.cover,)),
                      Row(
                        children: [
                          Flexible(child: GestureDetector(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>VideosViewPage()));
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewPage()));
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


                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Color(0xffececec), borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))),
                    child: ContentWidget(content: contents[0]["content"],
                      imageLink:"https://cdn1.ntv.com.tr/gorsel/ks_hXXjQy0-_BVNgNraKdw.jpg?width=1000&mode=both&scale=both&v=1587280799431" ,
                      title: contents[0]["title"],
                    ),
                  ),
                ]
            ),
    );
  }
}