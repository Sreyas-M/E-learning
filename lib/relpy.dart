import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'bottom_nav.dart';
import 'provider/feedbackprovider.dart';
import 'provider/loginprovider.dart';
import 'provider/replyprovider.dart';

class ReplySend extends StatelessWidget {
  const ReplySend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Reply'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Write your reply:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller:
              Provider.of<ReplyProvider>(context, listen: false).Replysend,
              maxLines: 5, // Allowing multiple lines for longer replies
              decoration: InputDecoration(
                hintText: "Type your reply here",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    Provider.of<ReplyProvider>(context, listen: false)
                        .Replysend
                        .clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final replyText =
                    Provider.of<ReplyProvider>(context, listen: false)
                        .Replysend
                        .text;

                if (replyText.isNotEmpty) {
                  // Only post if the reply is not empty
                  print('User ID: ${Provider.of<LoginProvider>(context, listen: false).user_id}');
                  await Provider.of<ReplyProvider>(context, listen: false)
                      .queryEnquiry(
                    reply: replyText,
                    user_id: Provider.of<LoginProvider>(context, listen: false)
                        .user_id
                        .toString(),
                  );

                  Fluttertoast.showToast(
                    msg: 'Reply posted successfully',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BottomNav(),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Please enter a valid reply',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
              ),
              child: Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
