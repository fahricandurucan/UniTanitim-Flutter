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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 100,//allImageList.length>0 ?(allImageList.length<=4? 100:200):0,
      child: Obx((){
        List allImageList = getxController.userImages.value;
        print("---------- ${allImageList}");
        return GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,//allImageList.length>4 ?2:1,
            ),
            itemCount: allImageList.length,// allImageList.length,
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
                          child: Image.file(File(allImageList[index]),fit: BoxFit.fill,),
                        ),

                        GestureDetector(
                            onTap: ()async{
                              int isDeleted= await deleteFile(File(allImageList[index]));
                              if(isDeleted ==1){
                                List<String> updatedList = [...allImageList.where((element ) => element!=allImageList[index]).toList()];
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
        );
      }
      ),
    );
  }




}
