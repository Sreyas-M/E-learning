import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyViewProvider extends ChangeNotifier{
  Future repliesfromAdmin({required userId}) async {
    var data = {"user_id": userId.toString()};
    Response response = await post(
        Uri.parse(
            "http://192.168.43.135/php/elearn/api/replyqueryapi.php"),
        body: data);
    if (response.statusCode == 200) {
      print('success');

      var  data1 = jsonDecode(response.body);
      print(data1);
      return data1;

    }
    notifyListeners();
  }

  Future removeReply({required id})async{
    var data={"id":id};
    Response response=await post(Uri.parse("http://192.168.43.135/php/elearn/api/cancelqueryapi.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Cleared Reply");
    }
    notifyListeners();
  }
}