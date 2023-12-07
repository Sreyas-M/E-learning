import 'package:elearning/provider/welcomeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //There is an ancestor error
    Future.delayed(Duration(seconds: 5)).whenComplete(() =>
        Provider.of<WelcomeProvider>(context, listen: false)
            .checkLogin(context));
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
                        SizedBox(height: 40),
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
