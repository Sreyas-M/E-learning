import 'dart:convert';
import 'package:elearning/ip.dart';
import 'package:elearning/login.dart';
import 'package:elearning/relpy.dart';
import 'package:elearning/replyView.dart';
import 'package:elearning/signout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  var data;
  var result;
  String? user_id;

  Future getUser() async {
    var user = {"id": user_id.toString()};
    try {
      Response response = await post(
          Uri.parse("http://192.168.43.135/php/elearn/api/viewuserapi.php?"),
          body: user);

      if (response.statusCode == 200) {
        var data1 = jsonDecode(response.body);

        if (data1 != null ) {
          data = data1;

          return data;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to load user data"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user")!;
    user_id = result.toString();
    setState(() {
      user_id;
    });
    print("Id is ${user_id}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
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
                  onTap: () { },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.question_answer_rounded),
                  title: Text('Question'),
                  onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReplySend()));},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('View Reply'),
                  onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Replies()));},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                  onTap: () {Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Userlogin()));},
                ),
                Divider(),
              ],
            );
          }else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }
}
