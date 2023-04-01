import 'package:flutter/material.dart';
import 'package:uni_tanitim/models/Category.dart';

import '../ContentPage.dart';

class MainCategories extends StatelessWidget {
  Category category;
  MainCategories({required this.category});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          // color: Colors.yellow,
          margin: EdgeInsets.all(8),
          width: 180,
          height: 270,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),

            child: Image.network(category.coverImage, fit: BoxFit.cover, color: Colors.white.withOpacity(0.5),
              colorBlendMode: BlendMode.modulate,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace){
                    return Icon(Icons.error_outline_rounded, color: Colors.yellow, size: 50,);
              },

            ),
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
                  child:Text(category.categoryName,style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,),
                )
            ),
            Container(
                width: 200,
                color: Color(0x6f000000),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child:Text(category.description,style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.center,),
                )
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 240),
          height: 100,
          width: 130,
          // color: Colors.greenAccent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 25),
                // color: Colors.pink,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContentPage(category: category,)));
                  },
                  child: Text("KEŞFET",style: TextStyle(fontFamily: 'Quicksand'),),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0x954800B1)
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