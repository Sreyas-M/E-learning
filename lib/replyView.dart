import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Replies extends StatefulWidget {
  const Replies({super.key});

  @override
  State<Replies> createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  Future repliesfromAdmin() async {
    var data = {"user_id": user_id};
    Response response = await post(
        Uri.parse(
            "http://192.168.43.135/php/elearn/api/replyqueryapi.php"),
        body: data);
    var data1;
    if (response.statusCode == 200) {
      data1 = jsonDecode(response.body);
    }
    return data1;
  }

  Future removeReply({required id})async{
    var data={"id":id};
    Response response=await post(Uri.parse("http://192.168.43.135/php/elearn/api/cancelqueryapi.php"),body: data);
    if(response.statusCode==200){
      Fluttertoast.showToast(msg: "cleared");
      setState(() {});
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
    userCrenditails();
    // TODO: implement initState
    repliesfromAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: repliesfromAdmin(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data['data'] == null) {
              return Center(child: Text("No data"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        snapshot.data["data"][index]["reply"],
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          snapshot.data["data"][index]["queries"] ?? "No data",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          removeReply(id: snapshot.data["data"][index]["q_id"]);
                        },
                        child: Text("Clear"),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
