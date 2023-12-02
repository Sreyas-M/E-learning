import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackProvider extends ChangeNotifier {
  Future feedBack({required feedback, required user_id}) async {
    var data = {
      "user_id": user_id,
      "feedback": feedback,
      "initial_date": DateTime.now().toString(),
    };
    Response response = await post(
      Uri.parse("http://192.168.43.135/php/elearn/api/feedbackapi.php"),
      body: data,
    );
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Thanks for your response");
    }
    notifyListeners();
  }
}
