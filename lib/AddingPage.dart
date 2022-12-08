import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'FirebaseOperations.dart';
import 'GetxControllerClass.dart';
import 'SharedPreferencesOperations.dart';
import 'widgets/imageGridWidget.dart';

class AddingPage extends StatelessWidget {
  String whichCategory;
  String categoryId;
  AddingPage({required this.categoryId,required this.whichCategory});

  @override
  Widget build(BuildContext context) {
//

    GetxControllerClass getxController = Get.put(GetxControllerClass());
    final firebaseStorage = FirebaseStorage.instance;
    FirebaseOperations firebaseOperations = FirebaseOperations();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(height: 60,
                  child: Row(
                    children: [
			//khdsblfgdlg

                      IconButton(
                          onPressed: (){
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_rounded)

                      )
                      ,

                      Spacer(),

                      Container(
                        height: 30,
                        margin: EdgeInsets.only(right: 15),
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(12)) ,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Row(
                            children: [
                              Text("Resim Ekle ",style: TextStyle(fontSize: 15,  fontWeight: FontWeight.w300)),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: ()async{
                                  XFile? file  = await ImagePicker().pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 75
                                  );
                                  if (file != null){
                                    final Directory duplicateFileDir = await getApplicationDocumentsDirectory();
                                    String duplicateFilePath = duplicateFileDir.path;
                                    final fileName = basename(file.path);
                                    await file.saveTo('$duplicateFilePath/$fileName');

                                    List<String> allImages = await getUserImages();
                                    allImages.add('$duplicateFilePath/$fileName');
                                    await setUserImages(allImages);

                                    getxController.userImages.value = allImages;
                                    print(getxController.userImages.value);
                                  }
                                },
                                  child: Image.asset("assets/add_image_gallery.png", height: 25,)),
                              SizedBox(width: 5,),
                              Container(height: double.infinity,width: 1, color: Colors.black87,),
                              SizedBox(width: 5,),
                              GestureDetector(
                                onTap: ()async{
                                  await ImagePicker().pickImage(
                                      source: ImageSource.camera,
                                      imageQuality: 75
                                  );
                                },
                                  child: Image.asset("assets/add_image_camera.png", height: 25,))

                            ],
                          ),
                        ) ,
                      ),

                    ],
                  ),
                ), //Back Icon



                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xfff3f3f3)),
                    margin: EdgeInsets.only(left: 10,right: 10),
                    padding: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children:  [
                          TextField(
                            onTap: (){
                            },
                            //controller: titleEditTextController,
                            style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Quicksand',),
                            decoration: InputDecoration(border: InputBorder.none, hintText:"Burası Neresi?"),
                            onSubmitted: (value){
                              //noteFocus.requestFocus();
                            },
                          ),

                          ImageGridView(),// IMAGES




                          TextField(
                            onTap: (){

                            },
                            maxLines: null,
                            //focusNode: noteFocus,
                            //controller: noteEditTextController,
                            style:  TextStyle(fontFamily: 'Quicksand',),
                            decoration:  InputDecoration(border: InputBorder.none, hintText: "Kısa bir açıklama ekleyebilirsiniz"),

                          ),
                          SizedBox(height: 200,)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //EnesDropDown(value: getCategoryName(widget.note.noteCategoryId??-1) ),


          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          for(String filePath in getxController.userImages.value){
            File file   =File(filePath);
            var profileRef = FirebaseStorage.instance.ref("Images/HomeCategoriesContents/${whichCategory.replaceAll(" ", "")}/gallery/${filePath.substring(filePath.length-23)}");

            profileRef.putFile(file).whenComplete(() async{
              String url = await profileRef.getDownloadURL();
              await firebaseOperations.updateGallery(categoryId,url);
            });
            print(filePath);

            }

        },
        label: const Text('Gönder'),
        icon: const Icon(Icons.send_rounded),
        backgroundColor: Colors.pink,
      ),



    );
  }
}
