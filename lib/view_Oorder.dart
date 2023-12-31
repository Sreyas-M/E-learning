import 'package:elearning/ip.dart';
import 'package:elearning/model/viewOrderModel.dart';
import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/provider/vieworderProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ViewOOrder extends StatelessWidget {
  const ViewOOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("My Orders",style: TextStyle(color: Colors.white)),
        ),
        body: StreamBuilder<OrderModel?>(
          stream: Provider.of<OrderProvider>(context, listen: false).viewOrders(
              user_data: Provider.of<LoginProvider>(context).user_id),
          builder: (BuildContext context, AsyncSnapshot<OrderModel?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.network(
                    "https://lottie.host/4d1ec630-cb30-4161-a07a-594ff4110911/34IxIdbFn5.json"),
              );
            }
            if (snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
              return Center(
                child: Text("No orders available"),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
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
                                    image: NetworkImage(
                                        "${ipData.ip}/${ipData.image}/${snapshot.data!.data![index].image1!}"),
                                    width: 80,
                                    height: 70,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.data![index].author!,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Price :\$${snapshot.data!.data![index].price!}",
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
                                      Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .removeOrder(
                                              o_id: snapshot
                                                  .data!.data![index].oId!);
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
