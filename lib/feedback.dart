import 'package:elearning/provider/feedbackprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/vieworderProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';

class FeedBack extends StatelessWidget {
  // const FeedBack({Key? key}) : super(key: key);

  TextEditingController feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<LoginProvider>(context, listen: false).user_id;
    return Scaffold(
        appBar: AppBar(
          title: Text('Feedback'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Share your feedback',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: feedback,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      feedback.clear();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Provider.of<FeedbackProvider>(context, listen: false)
                      .feedBack(
                    feedback: feedback.text,
                    user_id:
                    Provider.of<LoginProvider>(context, listen: false).user_id.toString(),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BottomNav(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Post Feedback',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
