import 'package:flutter/material.dart';
import 'package:uni_tanitim/FirebaseOperations%20.dart';

class Homepage extends StatelessWidget {

  FirebaseOperations firebaseOperations = FirebaseOperations();

  List titlelist = ["Kampüs","Barınma","Eğlence","Yorumlar","Yorumlar"];
  List imageList = ["kampus.jpg","barinma.jpg","eglence.jpg","yorum.jpg","soru.jpg"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: FutureBuilder(
              future: firebaseOperations.getInitCategories(),
              builder: ((context, AsyncSnapshot snapshot) {
                if(snapshot.data !=null){
                  return ListView(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            firebaseOperations.insertCategory("Gecilecek yerler, cafeler, etkinlikler", "https://www.turizmaktuel.com/image-upload/news/eglence-turizmi-50-buyuyecek_1450018508.jpg", "Eğlence", "universityId");
                          },
                          child: Text("Add Category")),
                      for(var i in snapshot.data)
                        Container(
                          height: 150,
                          margin: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(i["categoryImage"], fit: BoxFit.cover,width: 500,),
                                Container(
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  //alignment: i%2==0?Alignment.centerLeft:Alignment.centerRight,
                                  width: double.infinity,height: 40,color: Color(0x5C000000),
                                  child: Text(i["categoryName"], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),
                                ),
                              ],
                            ),

                          ),
                        ),
                    ],
                  );
                }else{
                  return Center(
                    child: Text("Ebenin ami", style: TextStyle(fontSize: 25),),
                  );
                }
              })
          ),
        ),
      ),
    );
  }
}
