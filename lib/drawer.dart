import 'dart:convert';
import 'package:elearning/ip.dart';
import 'package:elearning/login.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/welcomeprovider.dart';
import 'package:elearning/relpy.dart';
import 'package:elearning/replyView.dart';
import 'package:elearning/signout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feedback.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: Provider.of<LoginProvider>(context, listen: false)
            .getUser(context ,Provider.of<LoginProvider>(context, listen: false).user_id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(snapshot.data["data"]['firstname']),
                  accountEmail: Text(snapshot.data["data"]['email']),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                        child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Image.network(
                        "${ipData.ip}/${ipData.image2}/${snapshot.data["data"]["image"]}",
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    image: DecorationImage(
                        image: AssetImage('assets/tree.jpg'), fit: BoxFit.fill),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text('FeedBack'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FeedBack()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.question_answer_rounded),
                  title: Text('Question'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReplySend()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('View Reply'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Replies()));
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                  onTap: () async {
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setBool('user_logged', false);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Userlogin(),
                    ));
                  },
                ),
                Divider(),
              ],
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
