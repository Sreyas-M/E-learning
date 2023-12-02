import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DisplayProvider extends ChangeNotifier{
  var result;
  Future viewPackages() async {
    Response response = await get(
        Uri.parse("http://192.168.43.135/php/elearn/api/viewcourses_api.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      result = data;
      return result;
    }
    notifyListeners();
  }
}