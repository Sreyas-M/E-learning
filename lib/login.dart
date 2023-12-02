import 'dart:convert';
import 'package:elearning/bottom_nav.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/register.dart';
import 'package:elearning/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userlogin extends StatelessWidget {
  Userlogin({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey();
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
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                            Provider.of<LoginProvider>(context, listen: false)
                                .emailController,
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
                        controller:
                            Provider.of<LoginProvider>(context, listen: false)
                                .passwordController,
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
                                  bool validator =formKey
                                      .currentState!
                                      .validate();
                                  if (validator == true) {
                                    Provider.of<LoginProvider>(context,
                                            listen: false)
                                        .login(
                                      email: Provider.of<LoginProvider>(context,
                                              listen: false)
                                          .emailController
                                          .text,
                                      password: Provider.of<LoginProvider>(
                                              context,
                                              listen: false)
                                          .passwordController
                                          .text,
                                      context: context,
                                    );
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
