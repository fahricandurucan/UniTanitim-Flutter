import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/GetxControllerClass.dart';
import 'package:uni_tanitim/SPOperations.dart';
import 'package:uni_tanitim/widgets/imageGridWidget.dart';


class AddingPage2 extends StatefulWidget {
  String whichCategory;
  String categoryId;
  AddingPage2({required this.categoryId,required this.whichCategory});

  @override
  State<AddingPage2> createState() => _AddingPage2State();
}

class _AddingPage2State extends State<AddingPage2> {
  @override
  Widget build(BuildContext context) {
    final titleTextEditController = TextEditingController();
    final descTextEditController = TextEditingController();
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

                                      List<String> allImages = await SPOperations.getUserImages();
                                      allImages.add('$duplicateFilePath/$fileName');
                                      await SPOperations.setUserImages(allImages);
                                      getxController.userImages.value = allImages;
                                      print(getxController.userImages.value);
                                      setState(() {

                                      });
                                    }
                                  },
                                  child: Image.asset("assets/add_image_gallery.png", height: 25,)),
                              SizedBox(width: 5,),
                              Container(height: double.infinity,width: 1, color: Colors.black87,),
                              SizedBox(width: 5,),
                              GestureDetector(
                                  onTap: ()async{
                                    XFile? file  = await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 75
                                    );

                                    if (file != null){
                                      final Directory duplicateFileDir = await getApplicationDocumentsDirectory();
                                      String duplicateFilePath = duplicateFileDir.path;
                                      final fileName = basename(file.path);
                                      await file.saveTo('$duplicateFilePath/$fileName');

                                      List<String> allImages = await SPOperations.getUserImages();
                                      allImages.add('$duplicateFilePath/$fileName');
                                      await SPOperations.setUserImages(allImages);

                                      getxController.userImages.value = allImages;
                                      print(getxController.userImages.value);
                                    }
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
                            controller: titleTextEditController,
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
                            controller: descTextEditController,
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
          List<String> imageList = [];

          for(String filePath in getxController.userImages.value){
            File file   =File(filePath);
            var profileRef = FirebaseStorage.instance.ref("Images/HomeCategoriesContents/${widget.whichCategory.replaceAll(" ", "")}/gallery/${filePath.substring(filePath.length-23)}");
            await profileRef.putFile(file).whenComplete(() async{
              String url = await profileRef.getDownloadURL();
              imageList.add(url);
            });
          }
          Map<String,dynamic> userData = {"content":descTextEditController.text,"images":imageList, "path": widget.whichCategory, "title" :titleTextEditController.text};
          await firebaseOperations.addUserData(userData);
          Get.snackbar(
            "Gönderiminiz için teşekkür ederiz!",
            "",
            messageText: Text("Küçük bir kontrolden sonra yayınlanacaktır.",style: TextStyle(fontFamily: "Quicksand", color: Colors.white, fontSize: 15)),
            colorText: Colors.white,
            backgroundColor: Color(0xae000000),);

          descTextEditController.clear();
          titleTextEditController.clear();
          getxController.userImages.clear();

        },
        label: const Text('Gönder'),
        icon: const Icon(Icons.send_rounded),
        backgroundColor: Colors.pink,
      ),



    );
  }

  Future<String> uploadImagetoStorage({required String filePath})async {
    File file   =File(filePath);
    String url="";
    var profileRef = FirebaseStorage.instance.ref("userData${widget.whichCategory.replaceAll(" ", "")}/gallery/${filePath.substring(filePath.length-23)}");
    await profileRef.putFile(file).whenComplete(() async{
      url = await profileRef.getDownloadURL();
    });
    return url;
  }
}

