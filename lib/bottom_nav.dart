import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/userProfile.dart';
import 'package:elearning/view_Oorder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'fulldisplay.dart';
import 'login.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int mainindex = 0;
  List pages = [DisplayPage(), ViewOOrder(), Profile()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).user_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('user_logged', false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Userlogin(),
          ));
        },
      ),
      drawer: DrawerMenu(),
      body: pages[mainindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: mainindex,
        iconSize: 32,
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        selectedFontSize: 18,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'My Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
        ],
        onTap: (index) {
          setState(() {
            mainindex = index;
          });
        },
      ),
    );
  }
}
