import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';

class ReplySend extends StatefulWidget {
  const ReplySend({Key? key}) : super(key: key);

  @override
  State<ReplySend> createState() => _ReplySendState();
}

class _ReplySendState extends State<ReplySend> {
  TextEditingController Replysend=TextEditingController();
  Future queryEnquiry({required reply,required user_id})async{
    var data={"user_id":user_id,"query":reply,"date":DateTime.now().toString()};
    Response response=await post(Uri.parse("http://192.168.43.135/php/elearn/api/insertqueryapi.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "Will reply as soon as possible");
    }
  }
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user");
    setState(() {
      user_id = result.toString();
    });
    print("dat2 is ${user_id}");
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
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: Replysend,
              decoration: InputDecoration(
                  hintText: "Any Doubts ?",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Replysend.clear();
                    },
                    icon: const Icon(Icons.clear),
                  )),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                queryEnquiry(reply:Replysend.text, user_id: user_id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNav(),));
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
