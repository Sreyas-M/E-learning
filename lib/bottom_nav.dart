import 'package:elearning/userProfile.dart';
import 'package:elearning/view_Oorder.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'feedback.dart';
import 'fulldisplay.dart';
import 'login.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int mainindex =0;
  List pages=[DisplayPage(),FeedBack(),ViewOOrder(),Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback),label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'My Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Account')
        ],
        onTap: (index){
          setState(() {
            mainindex=index;
          });
        },
      ),
    );
  }
}
