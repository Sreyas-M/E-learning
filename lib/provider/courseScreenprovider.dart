import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CourseScreenProvider extends ChangeNotifier {
  var result;
  bool isVideo = true;
  getCourseData(BuildContext context, course_id) async {
    Response response = await post(
        Uri.parse(
            "http://192.168.43.135/php/elearn/api/singlecourseview_api.php"),
        body: {"id": course_id});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      result = data;
      return result;
    }
    notifyListeners();
  }

//need to createVideo Changing Button
  isVideoSelection() {
    isVideo = !isVideo;
    notifyListeners();
  }
}
