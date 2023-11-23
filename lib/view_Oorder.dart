import 'dart:convert';
import 'package:elearning/ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewOOrder extends StatefulWidget {
  const ViewOOrder({Key? key}) : super(key: key);

  @override
  State<ViewOOrder> createState() => _ViewOOrderState();
}

class _ViewOOrderState extends State<ViewOOrder> {
  var remove;
  Future removeOrder({required o_id}) async {
    var data = {"o_id": o_id};
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/removeorderapi.php"),
        body: data);
    if (response.statusCode == 200) {
      remove = jsonDecode(response.body);
      Fluttertoast.showToast(msg: "Removed");
    }
  }

  var user_data;
  Future viewOrders() async {
    var data = {"user_id": user_data.toString()};
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/vieworderapi.php"),
        body: data);
    var result;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      result = data;
      print(data["data"].runtimeType);
    }
    return result;
  }

  userCrenditails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user_data = sharedPreferences.getInt("user")!;
    print(user_data);
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
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("My Orders"),
        ),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1), viewOrders),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data["data"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image(
                                    image:
                                    NetworkImage(
                                        "${ipData.ip}/${ipData.image}/${snapshot.data["data"][index]['image1']}"),
                                    width: 80,
                                    height: 70,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data['data'][index]['author'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Price :\$300",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          "Ordered",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                thickness: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date : ${DateTime.now().toString().substring(0, 10)}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      removeOrder(
                                          o_id: snapshot.data["data"][index]
                                              ["o_id"]);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.red),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
          },
        ));
  }
}
