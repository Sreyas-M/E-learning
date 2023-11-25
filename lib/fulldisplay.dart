import 'dart:convert';
import 'dart:core';

import 'package:elearning/course_screen.dart';
import 'package:elearning/ip.dart';
import 'package:elearning/relpy.dart';
import 'package:elearning/replyView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key}) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  //course image and name display function
  var result;
  String? user_id;
  String? name;
  Future getUser() async {
    var user = {"id": user_id.toString()};
      Response response = await post(
          Uri.parse("http://192.168.43.135/php/elearn/api/viewuserapi.php?"),
          body: user);

      if (response.statusCode == 200) {
        var data1 = jsonDecode(response.body);
        print(data1);
        name=data1["data"]["firstname"];
        print(name);

          // return data1;
        }
    }
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var result = await sharedPreferences.getInt("user")!;
    user_id = result.toString();
    setState(() {
      user_id;
    });
    print(user_id);
  }

  // bool isSingleTrip = true;
  Future viewPackages() async {
    Response response = await get(
        Uri.parse("http://192.168.43.135/php/elearn/api/viewcourses_api.php"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        result = data;
      });
      return result;
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => getUser());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage('assets/tree.jpg'), fit: BoxFit.fill),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child:name==null?SizedBox(): Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      name!,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                //Corse Screen Top

                // GridView.builder(
                //   itemCount: catNames.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     childAspectRatio: 1.1,
                //   ),
                //   itemBuilder: (context, index) {
                //     return Column(
                //       children: [
                //         InkWell(
                //           onTap: () {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => Replies()));
                //           },
                //           child: Container(
                //             height: 60,
                //             width: 60,
                //             decoration: BoxDecoration(
                //               color: catColors[index],
                //               shape: BoxShape.circle,
                //             ),
                //             child: Center(
                //               child: catIcons[index],
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 10,
                //         ),
                //         Text(
                //           catNames[index],
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.w500,
                //               color: Colors.black.withOpacity(0.7)),
                //         )
                //       ],
                //     );
                //   },
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Courses",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Builder for courses
                FutureBuilder(
                    future: viewPackages(),
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState==ConnectionState.waiting){
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data["data"].length,
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
                                        img: snapshot.data["data"][index]
                                            ["image1"],
                                        course_id: snapshot.data['data'][index]
                                            ["course_id"],
                                        description: snapshot.data['data']
                                            [index]["description"],
                                        topicfir: snapshot.data['data'][index]
                                            ["topicfir"],
                                        topicsec: snapshot.data['data'][index]
                                            ["topicsec"],
                                        topicthird: snapshot.data['data'][index]
                                            ["topicthird"],
                                        topicfour: snapshot.data['data'][index]
                                            ["topicfour"],
                                        name: snapshot.data['data'][index]
                                            ["name"],
                                        author: snapshot.data['data'][index]
                                            ["author"],
                                        vidname: snapshot.data['data'][index]
                                            ["vidname"],
                                      ),
                                    ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade300),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Image.network(
                                          "${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]["image1"]}"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data['data'][index]['name'],
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
                                      snapshot.data['data'][index]['vidname'],
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
                                      "${snapshot.data['data'][index]['price']} /-",
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
                          child: Text("Error"),
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
