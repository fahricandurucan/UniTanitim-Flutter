import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/CategoryPage.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';

import 'GetxControllerClass.dart';

class Homepage extends StatelessWidget {
  FirebaseOperations firebaseOperations = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Text("Muğla Sıtkı Koçman Üniversitesi",overflow: TextOverflow.fade,)),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          child: FutureBuilder(
            future: firebaseOperations.getHomeCategories(),
            builder: ((context, AsyncSnapshot snapshot) {
              if(snapshot.data !=null){

                return ListView(
                  children: [
                    // ElevatedButton(
                    // onPressed: (){
                    //   firebaseOperations.insertCategory(title: "Eğlence", description: "Eğlence Açıklama", image: "https://www.turizmaktuel.com/image-upload/news/eglence-turizmi-50-buyuyecek_1450018508.jpg");
                    // },
                    // child: Text("Add Category")),
                    for(int i=0; i<snapshot.data.length; i++)
                      GestureDetector(
                        onTap: () async{
                          await getxController.getPlacesGetX(title: snapshot.data[i]["title"]);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(title: snapshot.data[i]["title"], subtitle: snapshot.data[i]["subtitle"],)));
                        },
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(snapshot.data[i]["image"], fit: BoxFit.cover,width: 500,),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  alignment: i%2==0?Alignment.centerLeft:Alignment.centerRight,
                                  width: double.infinity,height: 50,color: Color(0x5C000000),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data[i]["title"], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                                      Text(snapshot.data[i]["description"], style: TextStyle(fontSize: 16,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    
                  ],
                );
              }else{
                return Center(
                  child: Text("ERROR", style: TextStyle(fontSize: 25),),
                );
              }
            })
          ),
        ),
      ),
    );
  }
}

// TextButton(onPressed:(){
// firebaseOperations.insertCategory("Eğlence ile ilgili içerikler", "https://www.turizmaktuel.com/image-upload/news/eglence-turizmi-50-buyuyecek_1450018508.jpg", "Eğlence", "universityId");
// }, child: Text("Kategori Ekle")),
