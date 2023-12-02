import 'package:elearning/provider/courseScreenprovider.dart';
import 'package:elearning/provider/descriptionprovider.dart';
import 'package:elearning/provider/feedbackprovider.dart';
import 'package:elearning/provider/fullDisplayprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/registerprovider.dart';
import 'package:elearning/provider/replyViewprovider.dart';
import 'package:elearning/provider/replyprovider.dart';
import 'package:elearning/provider/vieworderProvider.dart';
import 'package:elearning/provider/welcomeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'welcome_screen.dart';


void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FeedbackProvider()),
    ChangeNotifierProvider(create: (context) => OrderProvider()),
    ChangeNotifierProvider(create: (context) => DisplayProvider()),
    ChangeNotifierProvider(create: (context) => LoginProvider()),
    ChangeNotifierProvider(create: (context) => WelcomeProvider()),
    ChangeNotifierProvider(create: (context) => ReplyProvider()),
    ChangeNotifierProvider(create: (context) => ReplyViewProvider()),
    ChangeNotifierProvider(create: (context) => RegisterProvider()),
    ChangeNotifierProvider(create: (context) => CourseScreenProvider()),
    ChangeNotifierProvider(create: (context) => DescProvider()),

  ], child: Myapp()));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home:BaseScreen(),
    );
  }
}
