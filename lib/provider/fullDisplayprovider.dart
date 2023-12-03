import 'dart:convert';

import 'package:elearning/model/fullCourseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';


class DisplayProvider extends ChangeNotifier{
  var result;
  Future<CourseModel> viewPackages(AsyncSnapshot) async {
    Response response = await get(
        Uri.parse("http://192.168.43.135/php/elearn/api/viewcourses_api.php"));
    if (response.statusCode == 200) {
      result =CourseModel.fromJson(jsonDecode(response.body));
    }
    notifyListeners();
    return result;

  }
}