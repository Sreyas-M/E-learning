import 'package:elearning/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  void logout(BuildContext context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('user_logged', false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => Userlogin(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
