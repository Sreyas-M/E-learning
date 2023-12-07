import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../model/fullCourseModel.dart';
import '../model/singleCourseViewModel.dart';

class CourseScreenProvider extends ChangeNotifier {
  SingleCourseView? result;
  bool isVideo = true;
  Stream <SingleCourseView?> getCourseData(context ,course_id) async* {
    Response response = await post(
        Uri.parse(
            "http://192.168.43.135/php/elearn/api/singlecourseview_api.php"),
        body: {"id": course_id});
    if (response.statusCode == 200) {
      result =SingleCourseView.fromJson(jsonDecode(response.body));
    }
   // notifyListeners();
    yield result;
  }

//need to createVideo Changing Button
  isVideoSelection() {
    isVideo = !isVideo;
    notifyListeners();
  }
}
