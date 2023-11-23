import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier{
  var data;
  var result;
  String? user_id;
  Future getUser(BuildContext context) async {
    var user = {"id":user_id.toString()};
    try {
      Response response = await post(
          Uri.parse("http://192.168.43.135/php/elearn/api/viewuserapi.php?"),
          body: user);

      if (response.statusCode == 200) {
        var data1 = jsonDecode(response.body);

        if (data1 != null && data1["data"] != null) {

            data = data1;

          return data;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User data not available"),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load user data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future userCrenditails()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    var result=await sharedPreferences.getInt("user");
    user_id=result.toString();
      user_id;
    print("id is ${user_id}");
    notifyListeners();
  }
}