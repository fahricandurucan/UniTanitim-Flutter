
import 'package:flutter/material.dart';

class LikeCountProvider extends ChangeNotifier{

   int like = 0;
   late bool isLiked ;



  


   int likeOku(int like){
    return like;
  }

  void likeArttir(int like){
    like = like+1;
    notifyListeners();
  }
  void likeAzalt(int like){
    like = like -1;
    isLiked = false;
    notifyListeners();
  }

  bool boolState(){
   return isLiked;
  }

  void boolTrue(){
     isLiked = true;
     notifyListeners();
  }
  void boolFalse(){
     isLiked= false;
     notifyListeners();
  }

}