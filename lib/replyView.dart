import 'dart:convert';

import 'package:elearning/provider/feedbackprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/replyViewprovider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Replies extends StatelessWidget {
  const Replies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replies'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future:Provider.of<ReplyViewProvider>(context, listen: false).repliesfromAdmin(userId: Provider.of<LoginProvider>(context,listen: false).user_id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );}
            if (snapshot.hasData && snapshot.data['data'] != null){
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
                          Provider.of<ReplyViewProvider>(context, listen: false).removeReply(id: snapshot.data["data"][index]["q_id"]);
                        },
                        child: Text("Clear"),
                      ),
                    ),
                  );
                },
              );
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
