import 'package:flutter/material.dart';

import 'FirebaseOperations.dart';
import 'widgets/youtubePlayerWidget.dart';

class VideosViewPage extends StatelessWidget {

  FirebaseOperations firebaseOperations = FirebaseOperations();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xd8000000),
        body: Stack(
          children: [
            Expanded(
              child: FutureBuilder(
                future: firebaseOperations.getPlaceUni(title: "Kampüs"),
                  builder: ((context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData){
                      return ListView(
                        children: [
                          SizedBox(height: 50,),
                          for(String link in snapshot.data[0]["videos"])
                            Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.yellow), borderRadius: BorderRadius.circular(18)),
                              height: 180,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: YoutubePlayerWidget(videoLink: link)
                              ),
                            ),

                          SizedBox(height: 100,)
                        ],
                      );
                    }else{
                      return CircularProgressIndicator();
                    }
                  })
              )

            ),

            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(color: Color(0xdf030202)),
              child: IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
                onPressed: ()async{

                  var contents = await firebaseOperations.getPlaceUni(title: "Kampüs");
                  print(contents[0]["videos"]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
