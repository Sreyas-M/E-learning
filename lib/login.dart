import 'dart:convert';

import 'package:elearning/bottom_nav.dart';
import 'package:elearning/register.dart';
import 'package:elearning/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userlogin extends StatefulWidget {
  const Userlogin({Key? key}) : super(key: key);

  @override
  State<Userlogin> createState() => UserloginState();
}

class UserloginState extends State<Userlogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formkey =GlobalKey();
  var data1;
  int user_id=0;
  Future  login()async{
    print("----");
    var data={
      "email":email.text,"password":pass.text
    };
    try{
      Response response=await post(Uri.parse("http://192.168.43.135/php/elearn/api/getuserapi.php"),body: data);
      print(response.body);
      if(response.statusCode==200){
        var result = jsonDecode(response.body);
          data1=result;
        print(data1);
        if(result["data"]==null){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please register"),));
        }
        else{
          var data1=result["data"]["user_id"];
          user_id=int.parse(data1);

          userCrenditails();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>BottomNav()));
        }
      }else {
        print("HTTP Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        Fluttertoast.showToast(
          msg: "Error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
          timeInSecForIosWeb: 5,
        );
      }
    }catch(e){
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
        timeInSecForIosWeb: 5,
      );

    }
  }
  userCrenditails()async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.setInt("user", user_id);
    sharedPreferences.setBool('user_logged', true);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2, top: 100),
              child: Text("Welcome\nBack",
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade600,
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade600,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromARGB(255, 60, 170, 223),
                            child: IconButton(
                                onPressed: () {
                                  bool validator=formkey.currentState!.validate();
                                  if(validator==true) {
                                    login();
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyRegister()));
                              },
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
