import 'package:flutter/material.dart';
import 'package:uni_tanitim/imageViewPage.dart';

class GalleryPage extends StatelessWidget {

  late List<dynamic> galeriImage;

  GalleryPage({required this.galeriImage});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Galeri",style: TextStyle(fontSize: 20,  decoration: TextDecoration.none, color: Colors.white)),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3/2.5,
                      crossAxisSpacing: 15,
                    ),
                    itemCount: galeriImage.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GestureDetector(
                              child: Image.network(galeriImage[index],fit: BoxFit.cover,),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewPage(galeriImage[index])));
                            },

                          ),
                          //Text("shfsudfg",style: TextStyle(fontSize: 16,  decoration: TextDecoration.none, color: Colors.black)),
                        ],
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}