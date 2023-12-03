import 'package:elearning/model/fullCourseModel.dart';
import 'package:elearning/provider/courseScreenprovider.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/widgets/description_section.dart';
import 'package:elearning/widgets/videos_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elearning/ip.dart';
import 'package:provider/provider.dart';

import 'model/singleCourseViewModel.dart';

class CourseScreen extends StatelessWidget {
  String course_id, name;
  CourseScreen({required this.course_id, required this.name});
  @override
  Widget build(BuildContext context) {
    Provider.of<LoginProvider>(context, listen: false).user_id;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        body: FutureBuilder<SingleCourseView>(
          future: Provider.of<CourseScreenProvider>(context)
              .getCourseData(context, course_id),
          builder: (BuildContext context, AsyncSnapshot<SingleCourseView> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                            image: NetworkImage(
                                "${ipData.ip}/${ipData.image}/${snapshot.data!.data!.image1!}"),
                          )),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xFF674AEF),
                            size: 45,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${snapshot.data!.data!.name!} Complete Course",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Created by ${snapshot.data!.data!.author!}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${snapshot.data!.data!.vidname!}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Material(
                            //if isVideosSection condition is true then that color will be on button and if
                            //condition is false then that color will be shown on the button with some opacity.
                            color: Provider.of<CourseScreenProvider>(context)
                                    .isVideo
                                ? Color(008000).withOpacity(0.6)
                                : Color(0xFFFF0000),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                Provider.of<CourseScreenProvider>(context,
                                        listen: false)
                                    .isVideoSelection();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 35),
                                child: Text(
                                  "videos",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Provider.of<CourseScreenProvider>(context)
                                    .isVideo
                                ? Color(0xFFFF0000)
                                : Color(008000).withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () {
                                Provider.of<CourseScreenProvider>(context,
                                        listen: false)
                                    .isVideoSelection();
                                //isVideosSection = false;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 35),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //We will create two different section
                    SizedBox(
                      height: 10,
                    ),
                    //condition checking
                    Provider.of<CourseScreenProvider>(context).isVideo
                        ? VideoSection(
                            author: snapshot.data!.data!.author!,
                            topicfour: snapshot.data!.data!.topicfour!,
                            topicthird: snapshot.data!.data!.topicthird!,
                            topicsec: snapshot.data!.data!.topicsec!,
                            topicfir: snapshot.data!.data!.topicfir!,
                          )
                        : DescriptionSection(
                            description: snapshot.data!.data!.description!,
                            course_id: snapshot.data!.data!.courseId!,
                            uder_id:
                                '${Provider.of<LoginProvider>(context, listen: false).user_id}',
                          ),
                  ],
                ),
              );
            } else {
              return Text("went Wrong");
            }
          },
        ));
  }
}
