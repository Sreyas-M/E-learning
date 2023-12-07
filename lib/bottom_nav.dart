import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/userProfile.dart';
import 'package:elearning/view_Oorder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fulldisplay.dart';

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
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).user_id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[mainindex],
      bottomNavigationBar: CurvedNavigationBar(
        index: mainindex,
        backgroundColor: Colors.blueAccent,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.home),
          Icon(Icons.shopping_cart),
          Icon(Icons.person)
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
