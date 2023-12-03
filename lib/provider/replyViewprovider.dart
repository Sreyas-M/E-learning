import 'dart:convert';
import 'package:elearning/model/replyViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class ReplyViewProvider extends ChangeNotifier{
  var  data1;
  Future<ReplyModel> repliesfromAdmin({required userId}) async {
    var data = {"user_id": userId.toString()};
    Response response = await post(
        Uri.parse(
            "http://192.168.43.135/php/elearn/api/replyqueryapi.php"),
        body: data);
    if (response.statusCode == 200) {
      print('success');
      data1 = ReplyModel.fromJson(jsonDecode(response.body));

    }
    notifyListeners();
    return data1;
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