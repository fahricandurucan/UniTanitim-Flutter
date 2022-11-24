import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_tanitim/ContentPage.dart';
import 'package:uni_tanitim/FirebaseOperations%20.dart';

import 'models/Content.dart';
import 'models/HomeCategoryContents.dart';

class CategoryPage extends StatefulWidget {


  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FirebaseOperations firestore = FirebaseOperations();





  // List<String> resimler(){
  //   List<String> resimler = [];
  //   resimler.add("fakulte.jpg");
  //   resimler.add("kutuphane.jpg");
  //   resimler.add("tip.jpg");
  //   resimler.add("fakulte.jpg");
  //   resimler.add("muhendislik.png");
  //   resimler.add("fakulte.jpg");
  //   return resimler;
  //
  // }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text("KAMPÜS",style: TextStyle(fontSize: 24),),
        ),

        body: FutureBuilder(
          future: firestore.getPlaceUni(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Fakülteler",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Container(
                      height: 300,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          //for(var i in resimler())
                          for(var i in snapshot.data)
                            Fakuteler(i["categoryName"],i["description"],i["image"],i["contents"]),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15,bottom: 15),
                    child: Text("Diger",style: TextStyle(fontSize: 18,color: Colors.white),),
                  ),
                  Container(
                    height: 300,
                    child:
                    Diger(),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        Content content1 = Content(content: "içerik 1",title: "başlık 1", image: "resim1");
                        Content content2 = Content(content: "içerik 2",title: "başlık 2", image: "resim2");
                        HomeCategoryContents homeCategoryContent = HomeCategoryContents(categoryName: "Fen-Edebiyat Fakültesi", contents: [content1.toMap(),content2.toMap()], description: "fen-edebiyat açıklama...", image: "https://docs.kariyer.net/job/jobtemplate/000/000/223/avatar/22353420200707061403281.png", universityId: "uniID3");
                        // firestore.addData(homeCategoryContent);
                      });
                    },
                    child: Text("EKLE"),
                  ),
                ],
              );
            }
            else{
              return Center();
            }
          },
        ),
      ),
    );

  }
}


class Fakuteler extends StatelessWidget {
  String title;
  String description;
  String image;
  List<dynamic> contents;
  Fakuteler(this.title,this.description,this.image,this.contents);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // color: Colors.yellow,
          margin: EdgeInsets.all(8),
          width: 180,
          height: 230,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(image, fit: BoxFit.cover, color: Colors.white.withOpacity(0.5), colorBlendMode: BlendMode.modulate,),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 200,
                color: Color(0x6f000000),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:Text(title,style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                )
            ),
            Container(
                width: 200,
                color: Color(0x6f000000),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:Text(description,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,),
                )
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 200),
          height: 100,
          width: 100,
          // color: Colors.greenAccent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                // color: Colors.pink,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContentPage(contents: contents,)));
                  },
                  child: Text("KEŞFET"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Diger extends StatelessWidget {
  List<Color> colorList= [Color(0xffffe500),Color(0xffd60061),Color(0xff008feb),Color(0xffdbdbdb),Color(0xff00bb50),Color(0xffff8a00)];
  List<String> places= ["Yemekhane","Gençlik Merkezleri","Kütüphane","Kültür Merkezi","Kantinler","Diğer"];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: places.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio:1,

        ),
        itemBuilder: (context,indeks){
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colorList[indeks],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              Text(places[indeks],style: TextStyle(fontSize: 14,color: Colors.white),),
            ],
          );
        }
    );
  }
}
