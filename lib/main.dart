

import 'package:elearning/picking.dart';
import 'package:elearning/provider/profileprovider.dart';
import 'package:elearning/register.dart';
import 'package:elearning/relpy.dart';
import 'package:elearning/userProfile.dart';
import 'package:elearning/view_Oorder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_nav.dart';
import 'course_screen.dart';
import 'feedback.dart';
import 'fulldisplay.dart';
import 'welcome_screen.dart';
import 'login.dart';

void main() {
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => ProfileProvider()),
  ],
  child: Myapp()));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: BaseScreen(),
    );
  }
}
