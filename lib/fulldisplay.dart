import 'dart:core';
import 'package:elearning/course_screen.dart';
import 'package:elearning/ip.dart';
import 'package:elearning/model/fullCourseModel.dart';
import 'package:elearning/provider/fullDisplayprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'login.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<LoginProvider>(context, listen: false).user_id;
    Provider.of<LoginProvider>(context, listen: false).getUser(context, uid);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "E-learning".toUpperCase(),
          style: TextStyle(color: Colors.white,letterSpacing: 2),
        ),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Sign Out"),
                      onTap: ()async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setBool('user_logged', false);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Userlogin()));
                      },
                    )
                  ]),
        ],
      ),
      drawer: DrawerMenu(),
      body: ListView(
        children: [

          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  "Courses",
                  style:
                      TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10
                ),
                //Builder for courses
                FutureBuilder<CourseModel>(
                    future: Provider.of<DisplayProvider>(context, listen: false)
                        .viewPackages(context),
                    builder: (context, AsyncSnapshot<CourseModel> snapshot) {
                      // if (snapshot.connectionState==ConnectionState.waiting){
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio:
                                      (MediaQuery.of(context).size.height -
                                              50 -
                                              10) /
                                          (4 * 240),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CourseScreen(
                                        name: snapshot.data!.data![index].name!,
                                        course_id: snapshot
                                            .data!.data![index].courseId!,
                                      ),
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black26),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade300),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                          "${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].image1!}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.data![index].name!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.data![index].vidname!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${snapshot.data!.data![index].price!} /-",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Lottie.network(
                              "https://lottie.host/4d1ec630-cb30-4161-a07a-594ff4110911/34IxIdbFn5.json",
                              animate: true),
                        );
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
