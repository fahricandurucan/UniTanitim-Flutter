
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getUserImages() async{
  var settings = await SharedPreferences.getInstance();
  List<String> value =await settings.getStringList("userImages")??[];
  return value;
}

Future<void> setUserImages(List<String> value) async{
  var settings = await SharedPreferences.getInstance();
  await settings.setStringList("userImages", value);
}


Future<void> setCommentId(String commentId) async{
  var comment = await SharedPreferences.getInstance();
  await comment.setBool("${commentId}", true);
  print("$commentId kaydedildi");
}

Future<bool> getCommentId(String commentId)async{
  var comment = await SharedPreferences.getInstance();

  bool? state = await comment.getBool("${commentId}") ?? true;
  print("$commentId  ---- $state)");
  return state;
}