import 'package:elearning/provider/feedbackprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/replyprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';

class ReplySend extends StatelessWidget {
  const ReplySend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // Provider.of<FeedbackProvider>(context, listen: false).userCrenditails();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller:
                  Provider.of<ReplyProvider>(context, listen: false).Replysend,
              decoration: InputDecoration(
                  hintText: "Any Doubts ?",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Provider.of<ReplyProvider>(context, listen: false)
                          .Replysend
                          .clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                print(
                    'uid used ${Provider.of<LoginProvider>(context, listen: false).user_id}');
                Provider.of<ReplyProvider>(context, listen: false).queryEnquiry(
                    reply: Provider.of<ReplyProvider>(context, listen: false)
                        .Replysend
                        .text,
                    user_id:
                        Provider.of<LoginProvider>(context, listen: false)
                            .user_id.toString());
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
