import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier{
  var remove;
  var result;
  Future removeOrder({required o_id}) async {
    var data = {"o_id": o_id};
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/removeorderapi.php"),
        body: data);
    if (response.statusCode == 200) {
      remove = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "Removed");
    }
    notifyListeners();
  }

  Future viewOrders({required user_data}) async {
    var data = {"user_id": user_data.toString()};
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/vieworderapi.php"),
        body: data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      result = data;
      print(data["data"].runtimeType);
      return result;
    }
    notifyListeners();
  }
}