import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/models/Category.dart';

import '../ContentPage.dart';
import '../GetxControllerClass.dart';

class OtherCategories extends StatelessWidget {
  List<Color> colorList= [Color(0xffffe500),Color(0xffd60061),Color(0xff008feb),Color(0xffdbdbdb),Color(0xff00bb50),Color(0xffff8a00)];

  List<dynamic> digerList;
  OtherCategories(this.digerList);

  GetxControllerClass getxController = Get.put(GetxControllerClass());

  @override
  Widget build(BuildContext context) {
    print("*****diger list lenght : "+digerList.length.toString());
    return GridView.builder(
        itemCount: digerList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio:1,
        ),
        itemBuilder: (context,indeks){
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  Category c = digerList[indeks];
                  print("************* other cotegori *********** : ${c.categoryName}");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContentPage(category: c,)));

                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: colorList[indeks],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Container(
                        height: 70,
                        width: 70,
                        child: Image.network(digerList[indeks].coverImage,fit: BoxFit.cover,)
                    ),
                  ],
                ),
              ),
              Text(digerList[indeks].categoryName,style: TextStyle(fontSize: 14,color: Colors.white),),
            ],
          );
        }
    );
  }
}