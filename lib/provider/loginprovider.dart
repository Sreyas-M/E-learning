import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_nav.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var data1;
  int user_id = 0;
  var data;
  var name;
  bool secure = true;

  Future login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    print("----");
    var data = {"email": email, "password": password};
    try {
      Response response = await post(
          Uri.parse("http://192.168.43.135/php/elearn/api/getuserapi.php"),
          body: data);
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool("user_logged", true);

        var result = jsonDecode(response.body);
        data1 = result;
        if (result["data"] == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Please register"),
          ));
        } else {
          var data1 = result["data"]["user_id"];
          user_id = int.parse(data1);
          preferences.setInt("user", user_id);
          print("Login Func UserId${user_id}");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomNav()));
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Fluttertoast.showToast(
          msg: "Error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          timeInSecForIosWeb: 5,
        );
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 5,
      );
    }
    notifyListeners();
  }

  Future getUser(BuildContext context, userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getInt("user")!;
    print('uid get $user_id');
    var user = {"id": user_id.toString()};
    try {
      Response response = await post(
          Uri.parse("http://192.168.43.135/php/elearn/api/viewuserapi.php?"),
          body: user);
      if (response.statusCode == 200) {
        print('success ');
        var data1 = jsonDecode(response.body);
        print('json decode');
        print(data1);
        if (data1 != null) {
          print('not null');
          data = data1;
          name = data["data"]["firstname"];
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
    }
    notifyListeners();
  }

  void security() {
    secure = !secure;
    notifyListeners();
  }

  void clearText() {
    emailController.clear();
    passwordController.clear();
  }
}
