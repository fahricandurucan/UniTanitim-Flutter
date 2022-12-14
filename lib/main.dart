import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uni_tanitim/models/LikeCountProvider.dart';

import 'ContentPage.dart';
import 'Homepage.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LikeCountProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homepage()
    ),

    );

  }
}
