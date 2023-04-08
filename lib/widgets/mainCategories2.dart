import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_tanitim/ContentPage.dart';

class MainCategories2 extends StatefulWidget {
  List list;
  MainCategories2(this.list);

  @override
  State<MainCategories2> createState() => _MainCategories2State();
}

class _MainCategories2State extends State<MainCategories2> {
  int centerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350,
        child: CarouselSlider.builder(
          itemCount: widget.list.length,
          options: CarouselOptions(
            height: 350,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            initialPage: centerIndex,
            viewportFraction: 0.7,
            enableInfiniteScroll: false,
            padEnds: false,
            onPageChanged: (index, reason) {
              setState(() {
                centerIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, _ ) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(widget.list[index].coverImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomCenter,
                      child: index == centerIndex
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 100,
                                width: double.infinity,
                                child: Text(widget.list[index].categoryName,
                                  style: TextStyle(color: Color(0xefffffff), fontSize: 20,
                                      fontFamily: 'K2D'),),

                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.3),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.7),
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(0.3),
                                      Colors.transparent,
                                    ],

                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              SizedBox(height: 90,),
                              InkWell(
                               onTap: (){
                                 Get.to(() => ContentPage(category: widget.list[index]));
                                 //Get.to(ContentPage(category: widget.list[index]));
                               },
                               child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                color: Color(0xc7001567),
                                borderRadius: BorderRadius.vertical(
                                 bottom: Radius.circular(16),
                               ),
                               ),
                                   child: Text(
                                     "KEŞFET",
                                     style: TextStyle(color: Color(0xFFFFFFFF),
                                         fontSize: 20,
                                         fontFamily: 'K2D'),
                                     maxLines: 1,
                                     textAlign: TextAlign.center,
                                   ),
                        ),
                              ),
                            ],
                          )
                          : const SizedBox(),
                    ),
                  ),
                ],
            );
          },
        ),
      ),
    );
  }
}