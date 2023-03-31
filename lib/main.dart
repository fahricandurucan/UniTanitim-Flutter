import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_tanitim/CategoryPage.dart';
import 'package:uni_tanitim/Homepage.dart';
import 'package:uni_tanitim/widgets/EnesAnimatedImageWidget.dart';
import 'package:uni_tanitim/widgets/EnesShowUpText.dart';

import 'ContentPage.dart';
import 'firebase_options.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Homepage()
    );
  }
}
