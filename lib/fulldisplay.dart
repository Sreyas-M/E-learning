import 'dart:core';
import 'package:elearning/course_screen.dart';
import 'package:elearning/ip.dart';
import 'package:elearning/model/fullCourseModel.dart';
import 'package:elearning/provider/fullDisplayprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<LoginProvider>(context, listen: false).user_id;
    Provider.of<LoginProvider>(context, listen: false).getUser(context,uid);
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
                  child:Provider.of<LoginProvider>(context).name==null?SizedBox(): Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      Provider.of<LoginProvider>(context).name!,
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
                FutureBuilder<CourseModel>(
                    future: Provider.of<DisplayProvider>(context, listen: false).viewPackages(context),
                    builder: (context,AsyncSnapshot<CourseModel> snapshot) {
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
                                        // img: snapshot.data["data"][index]
                                        //     ["image1"],
                                        // course_id: snapshot.data['data'][index]
                                        //     ["course_id"],
                                        // description: snapshot.data['data']
                                        //     [index]["description"],
                                        // topicfir: snapshot.data['data'][index]
                                        //     ["topicfir"],
                                        // topicsec: snapshot.data['data'][index]
                                        //     ["topicsec"],
                                        // topicthird: snapshot.data['data'][index]
                                        //     ["topicthird"],
                                        // topicfour: snapshot.data['data'][index]
                                        //     ["topicfour"],
                                        name: snapshot.data!.data![index].name!,
                                        // author: snapshot.data['data'][index]
                                        //     ["author"],
                                        // vidname: snapshot.data['data'][index]
                                        //     ["vidname"],
                                        course_id: snapshot.data!.data![index].courseId!,
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
