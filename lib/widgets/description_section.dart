import 'dart:convert';

import 'package:elearning/provider/descriptionprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/loginprovider.dart';
import '../view_Oorder.dart';

class DescriptionSection extends StatelessWidget {
  //const DescriptionSection({Key? key}) : super(key: key);
  final String course_id, uder_id, description;
  DescriptionSection(
      {required this.course_id,
      required this.uder_id,
      required this.description});

  @override
  Widget build(BuildContext context) {
    Provider.of<LoginProvider>(context, listen: false).user_id;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            description,
            style: TextStyle(
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
            onPressed: () async {
              Provider.of<DescProvider>(context, listen: false)
                  .purchaseOrder(context, course_id);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ViewOOrder()));
              // await makePayment();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
