import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

class ImageViewPage extends StatelessWidget {

  late List<dynamic> galeriImage;

  ImageViewPage({required this.galeriImage});


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
                          FullScreenWidget(
                            child: Center(
                              child: Hero(
                                tag: "imageTag",
                                child: InteractiveViewer(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(galeriImage[index],fit: BoxFit.cover,)),
                                ),
                              ),
                            ),
                          ),

                          Text("shfsudfg",style: TextStyle(fontSize: 16,  decoration: TextDecoration.none, color: Colors.black)),
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