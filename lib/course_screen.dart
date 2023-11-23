import 'package:elearning/widgets/description_section.dart';
import 'package:elearning/widgets/videos_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elearning/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseScreen extends StatefulWidget {
  String img;
  String course_id,
      name,
      author,
      vidname,
      topicfir,
      topicsec,
      topicthird,
      topicfour,
      description;
  CourseScreen(
      {required this.img,
      required this.name,
      required this.topicfir,
      required this.topicsec,
      required this.topicthird,
      required this.topicfour,
      required this.author,
      required this.course_id,
      required this.description,
      required this.vidname});
  //const CourseScreen({Key? key}) : super(key: key);
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool isVideosSection = true;
  var user_id;
  Future userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_id = sharedPreferences.getInt("user") ?? 1;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCrenditails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications,
              size: 28,
              color: Color(0xFF674AEf),
            ),
          )
        ],
      ),
      body: Padding(
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
                        "${ipData.ip}/${ipData.image}/${widget.img}"),
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
              "${widget.name} Complete Course",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Created by ${widget.author}",
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
              "${widget.vidname}",
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    //if isVideosSection condition is true then that color will be on button and if
                    //condition is false then that color will be shown on the button with some opacity.
                    color: isVideosSection
                        ? Color(0xFF674AEF)
                        : Color(0xFF674AEF).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        // Change Value of isVideosSection
                        setState(() {
                          isVideosSection = true;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 35),
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
                    color: isVideosSection
                        ? Color(0xFF674AEF).withOpacity(0.6)
                        : Color(0xFF674AEF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isVideosSection = false;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 35),
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
            isVideosSection
                ? VideoSection(
                    author: widget.author,
                    topicfour: widget.topicfour,
                    topicthird: widget.topicthird,
                    topicsec: widget.topicsec,
                    topicfir: widget.topicfir,
                  )
                : DescriptionSection(
                    description: widget.description,
                    course_id: widget.course_id,
                    uder_id: '${user_id}',
                  ),
          ],
        ),
      ),
    );
  }
}
