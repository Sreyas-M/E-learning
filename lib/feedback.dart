import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';

class FeedBack extends StatefulWidget {
  // const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController feedback = TextEditingController();
  Future feedBack({required feedback, required user_id}) async {
    var data = {
      "user_id": user_id,
      "feedback": feedback,
      "initial_date": DateTime.now().toString()
    };
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/feedbackapi.php"),
        body: data);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Thanks for your response");
    }
  }

  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user");
    setState(() {
      user_id = result.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FeedBack'),backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: feedback,
              decoration: InputDecoration(
                  hintText: "What's on your mind ?",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      feedback.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                feedBack(feedback: feedback.text, user_id: user_id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => BottomNav(),
                ));
              },
              color: Colors.blueAccent,
              child: Text(
                'Post',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
