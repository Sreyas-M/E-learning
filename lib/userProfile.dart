import 'dart:convert';
import 'package:elearning/ip.dart';
import 'package:elearning/provider/profileprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).userCrenditails();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
            child: Text(
          "Profile",
          style: TextStyle(fontSize: 30),
        )),
      ),
      body: FutureBuilder(
          future: Provider.of<ProfileProvider>(context, listen: false)
              .getUser(context),
          builder: (context, snapshot) {
            // if(snapshot.connectionState==ConnectionState.waiting){
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            if (snapshot.hasData) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${ipData.ip}/${ipData.image2}/${snapshot.data["data"]["image"]}"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data["data"]["firstname"],
                            style: TextStyle(color: Colors.black, fontSize: 40),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            snapshot.data["data"]["lastname"],
                            style: TextStyle(color: Colors.black, fontSize: 40),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Icon(
                              Icons.call,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text(
                              "Phonenumber",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Text(
                        snapshot.data["data"]["phone"],
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      SizedBox(height: 50),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Icon(
                              Icons.email_rounded,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Text(
                              "Email",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      Text(
                        snapshot.data["data"]["email"],
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("dfghj"),
              );
            }
          }),
    );
  }
}
