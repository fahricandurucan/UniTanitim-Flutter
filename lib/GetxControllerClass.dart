
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'SharedPreferencesOperations.dart';

class GetxControllerClass extends GetxController{

  var userImages= [].obs;


  @override
  void onInit() async{
    List images = await getUserImages();
    userImages.value = images;
    print("************* ${userImages}");
    super.onInit();
  }



}