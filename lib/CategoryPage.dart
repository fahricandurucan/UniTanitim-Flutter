
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/ContentPage.dart';
import 'package:uni_tanitim/widgets/mainCategories2.dart';
import 'package:uni_tanitim/widgets/mainCategories.dart';

import 'FirebaseOperations.dart';
import 'GetxControllerClass.dart';
import 'models/Content.dart';
import 'models/Category.dart';
import 'widgets/otherCategories.dart';

class CategoryPage extends StatefulWidget {
  late String title;
  late String subtitle;
  CategoryPage({required this.title,required this.subtitle});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FirebaseOperations firestore = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(widget.title,style: TextStyle(fontSize: 24),),
        ),

        body: ListView(
          children: [

            //***** KATEGORİ EKLEME BUTONU  ****
            ElevatedButton(
                onPressed: (){
                  Content content1 = Content(content: "", title: "", image: "");
                  List<String> galeriImages = ["image link 1","image link 2"];
                  List<String> videos = ["video link 1","video link 2"];
                  Category category = Category(
                      categoryName: "Kantin",
                      contents: [content1.toMap(),content1.toMap(),content1.toMap(), content1.toMap(),content1.toMap(),
                        content1.toMap(),content1.toMap(),content1.toMap(),content1.toMap(),content1.toMap(),content1.toMap(),
                        content1.toMap(),content1.toMap(),content1.toMap()],
                      description: "Açıklama",
                      coverImage: "Resim",
                      universityId:"mskü",
                      galleryImages: galeriImages,
                      videos: videos,
                      categoryId: '',
                      isOther :1,

                  );
                  firestore.addData2(category, widget.title);
                },

                onLongPress: (){

                },
                child: Text("${widget.title}'e Kategori Ekle")
            ),
            Text("Diğer için basılı tut"),

            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(widget.subtitle,style: TextStyle(fontSize: 18,color: Colors.white),),
            ),

            MainCategories2(getxController.places.value.where((element) => element.isOther ==0).toList()),


           // Padding(
           //   padding: EdgeInsets.only(bottom: 15),
           //   child: Container(
           //     height: 300,
           //     child: ListView(
           //       shrinkWrap: true,
           //       scrollDirection: Axis.horizontal,
           //       children: [
           //
           //         // for(Category category in getxController.places.value.where((element) => element.isOther ==0))
           //         //   MainCategories(category: category,),
           //       ],
           //     ),
           //   ),
           // ),


            Padding(
              padding: EdgeInsets.only(left: 15,bottom: 15),
              child: Text("Diğer",style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
            Container(
              height: 300,
              child: OtherCategories(getxController.places.value.where((element) => element.isOther ==1).toList())
            ),
          ],
        ),
      ),
    );

  }
}






