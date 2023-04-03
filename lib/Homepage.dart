import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/CategoryPage.dart';
import 'package:uni_tanitim/FirebaseOperations.dart';
import 'package:uni_tanitim/widgets/mainCategories2.dart';

import 'GetxControllerClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin {

    FirebaseOperations firebaseOperations = FirebaseOperations();
  GetxControllerClass getxController = Get.put(GetxControllerClass());
    late AnimationController _controller;

    @override
  void initState() {



      _controller = AnimationController(
        duration: const Duration(milliseconds: 3000),
        vsync: this,
      );
      _controller.forward();
    super.initState();
  }

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

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int i){

                      final animation = Tween(begin: 0.0, end: 3.0).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                            (i + 1) / 10,
                            1.0,
                            curve: Curves.easeInOutCirc
                        ),
                      ));

                      return FadeTransition(
                        opacity: animation,
                        child: Transform.translate(
                          offset: Offset(0,0),
                          child: GestureDetector(
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
                        ),
                      );
                    },
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


