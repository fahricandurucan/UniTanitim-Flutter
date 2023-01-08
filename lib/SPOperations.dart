
import 'package:shared_preferences/shared_preferences.dart';

class SPOperations{
   static Future<List<String>>  getUserImages() async{
    var settings = await SharedPreferences.getInstance();
    List<String> value =await settings.getStringList("userImages")??[];
    return value;
  }

   static Future<void> setUserImages(List<String> value) async{
    var settings = await SharedPreferences.getInstance();
    await settings.setStringList("userImages", value);
  }

   static Future<bool> setLikeStatus(String commentId, bool isLiked) async{
    final bool success;
    var comment = await SharedPreferences.getInstance();
    success= await comment.setBool("${commentId}", isLiked);
    print("$commentId kaydedildi");
    return success;
  }

   static Future<bool> getLikeStatus(String commentId)async{
    var comment = await SharedPreferences.getInstance();
    bool? state = await comment.getBool("${commentId}") ?? false;
    print("$commentId  ---- $state)");
    return state;
  }
}