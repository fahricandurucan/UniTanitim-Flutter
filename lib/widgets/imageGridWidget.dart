import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/SPOperations.dart';

import '../GetxControllerClass.dart';

class ImageGridView extends StatelessWidget {
  GetxControllerClass getxController = Get.put(GetxControllerClass());

  Future<int> deleteFile(File file) async {
    try {
      await file.delete();
      return 1;
    } catch (e) {
      print("Silme İslemi Başarısız !!");
      return 0;
    }
  }
  //List allImageList2 = getxController.userImages;

  @override
  Widget build(BuildContext context) {
    //List allImageList = getxController.userImages.value;
    return Obx(() {
      List allImageList2 = getxController.userImages;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: allImageList2.length>0 ?(allImageList2.length<=4? 100:200):0,
        child:
        GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,//allImageList.length>4 ?2:1,
            ),
            itemCount: allImageList2.length,// allImageList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewPage(path: allImageList[index],imageId:imageId ,)));
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: 100,width: 100,
                          child: Image.file(File(allImageList2[index]),fit: BoxFit.fill,),
                        ),

                        GestureDetector(
                            onTap: ()async{
                              int isDeleted= await deleteFile(File(allImageList2[index]));
                              if(isDeleted ==1){
                                List<String> updatedList = [...allImageList2.where((element ) => element!=allImageList2[index]).toList()];
                                SPOperations.setUserImages(updatedList);
                                getxController.userImages.value=updatedList;
                              }

                            },
                            child: Icon(Icons.cancel_rounded, size: 20, color: Color(
                                0xffe20000),)),

                      ],
                    ),
                  ),
                ),
              );
            }
        )

    );} );


  }




}
