import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'loginprovider.dart';

class DescProvider extends ChangeNotifier {
  Future purchaseOrder(BuildContext context, course_id) async {
    var data = {
      "course_id": course_id.toString(),
      "user_id": Provider.of<LoginProvider>(context, listen: false).user_id.toString(),
      "date": DateTime.now().toString()
    };
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/insertorderapi.php"),
        body: data);
    print(data);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Course Registered")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration failed")));
    }
    notifyListeners();
  }
}
