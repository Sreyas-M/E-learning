import 'package:elearning/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav.dart';
import 'fulldisplay.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userLoginCred = pref.getBool('user_logged');
    if(userLoginCred ==true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(),));
      Fluttertoast.showToast(msg: "Welcome");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Userlogin(),));
      Fluttertoast.showToast(msg: "Please login");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).whenComplete(() => checkLogin());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Expanded(child: Image.asset("assets/images/welcome.png"))
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Container(
                color: Colors.blueAccent,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50))),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Learning Everything",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Learn with pleasure with\n Us,where you are!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              wordSpacing: 1.5,
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.5,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          //button position
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              height: 60,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: Colors.pink,
                              onPressed: () {
                                //home screen path
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BottomNav()));

                              },
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
