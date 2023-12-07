import 'package:elearning/ip.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/widgets/user_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "User Profile",
          style: TextStyle(fontSize: 30,color: Colors.white),
        ),
      ),
      body: FutureBuilder(
          future: Provider.of<LoginProvider>(context, listen: false)
              .getUser(context,Provider.of<LoginProvider>(context).user_id),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: Lottie.network(
                    "https://lottie.host/4d1ec630-cb30-4161-a07a-594ff4110911/34IxIdbFn5.json",
                    animate: true),
              );
            }
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blueAccent, Colors.blueAccent],
                  ),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    ClipOval(
                      child: Image.network(
                        "${ipData.ip}/${ipData.image2}/${snapshot.data["data"]["image"]}",
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SizedBox(height: 40),
                    UserTile(head: 'Name :', value: snapshot.data['data']['firstname']),
                    SizedBox(height: 20,),
                    UserTile(head: 'E-Mail :', value: snapshot.data["data"]["email"]),
                    SizedBox(height: 20,),
                    UserTile(head: "Phone :", value: snapshot.data["data"]["phone"])
                  ],
                ),
              );
            } else {
              return Center(
                child: Text("Not Found"),
              );
            }
          }),
    );
  }
}
