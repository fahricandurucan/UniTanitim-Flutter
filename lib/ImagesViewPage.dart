import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({Key? key}) : super(key: key);

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
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network("https://cdn1.ntv.com.tr/gorsel/6BjUUb14Bke-kYHi8i5SgA.jpg?width=990&height=730&mode=crop&scale=both&v=20200419071959431",fit: BoxFit.cover,),
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