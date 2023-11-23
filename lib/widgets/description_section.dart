import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_Oorder.dart';

class DescriptionSection extends StatefulWidget {
  //const DescriptionSection({Key? key}) : super(key: key);
  final String course_id;
  final String uder_id;
 String description;
  DescriptionSection({required this.course_id, required this.uder_id,required this.description});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  //void _showPaymentBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Select a Payment Option',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 16),
  //             ListTile(
  //               leading: Icon(Icons.credit_card),
  //               title: Text('Credit Card'),
  //               onTap: () {
  //                 // Handle credit card payment
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.payment),
  //               title: Text('PayPal'),
  //               onTap: () {
  //                 // Handle PayPal payment
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             // Add more payment options as needed
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future purchaseOrder() async {
    var data = {
      "course_id": widget.course_id.toString(),
      "user_id": widget.uder_id,
      "date": DateTime.now().toString()
    };
    Response response = await post(
        Uri.parse("http://192.168.43.135/php/elearn/api/insertorderapi.php"),
        body: data);
    print(data);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registerd successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(widget.description,style: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Course Length:",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.timer,
                color: Color(0xff674aef),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "26 Hours",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "Rating:",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.star,
                color: Colors.amber,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "4.5",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              purchaseOrder();
              //_showPaymentBottomSheet(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewOOrder()));
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
