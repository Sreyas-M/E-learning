import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyProvider extends ChangeNotifier{
  TextEditingController Replysend=TextEditingController();
  Future queryEnquiry({required reply,required user_id})async{
    print('uid inside fumc $user_id');
    var data={"user_id":user_id,"query":reply,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.43.135/php/elearn/api/insertqueryapi.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Will reply as soon as possible");
    }
    notifyListeners();
  }
}