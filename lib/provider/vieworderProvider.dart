import 'dart:convert';
import 'package:elearning/model/viewOrderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class OrderProvider extends ChangeNotifier{
  var remove;
  OrderModel? result;
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

  Stream <OrderModel?> viewOrders({required user_data}) async*{

    var data = {"user_id": user_data.toString()};
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/vieworderapi.php"),
        body: data);
    if (response.statusCode == 200) {
      result =OrderModel.fromJson(jsonDecode(response.body));
    }
    yield result;
    notifyListeners();
  }
}