
import 'package:elearning/provider/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_nav.dart';
import '../login.dart';

class WelcomeProvider extends ChangeNotifier{
  var user_id;
  void checkLogin(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userLoginCred = pref.getBool('user_logged')??false;
     user_id = pref.getInt("user");
    Provider.of<LoginProvider>(context,listen: false).getUser(context, user_id);
    if(userLoginCred){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav(),));
      Fluttertoast.showToast(msg: "Welcome");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Userlogin(),));
      Fluttertoast.showToast(msg: "Please login");
    }
    notifyListeners();
  }
}