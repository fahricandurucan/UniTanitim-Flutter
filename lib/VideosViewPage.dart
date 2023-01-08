import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/models/Category.dart';
import 'package:uni_tanitim/widgets/youtubePlayerWidget.dart';

import 'GetxControllerClass.dart';

class VideosViewPage extends StatelessWidget {

  List videos;
  VideosViewPage({required this.videos});

  FirebaseOperations firebaseOperations = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xd8000000),
        body: Stack(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 50,),
                  for(String videoLink in videos)
                    Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.yellow), borderRadius: BorderRadius.circular(18)),
                      height: 180,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: YoutubePlayerWidget(videoLink: videoLink)
                      ),
                    ),

                  SizedBox(height: 100,)
                ],
              ),

            ),

            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Color(0xdf030202)),
              child: IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                onPressed: ()async{
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
