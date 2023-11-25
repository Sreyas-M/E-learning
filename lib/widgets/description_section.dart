import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view_Oorder.dart';

class DescriptionSection extends StatefulWidget {
  //const DescriptionSection({Key? key}) : super(key: key);
  final String course_id;
  final String uder_id;
  String description;
  DescriptionSection(
      {required this.course_id,
      required this.uder_id,
      required this.description});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  //Map<String, dynamic>? paymentIntentData;

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
          Text(
            widget.description,
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
              purchaseOrder();
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

  //Make payment Function
//   Future<void> makePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent('20', 'USD');
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//         paymentIntentClientSecret: paymentIntentData!['client_secret'],
//             style: ThemeMode.dark,
//             merchantDisplayName: 'ASIF'
//       ));
//       displayPaymentSheet();
//     } catch (e) {
//       print('exception' + e.toString());
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance
//           .presentPaymentSheet(
//         //       parameters: PresentPaymentSheetParameters(
//         // clientSecret: paymentIntentData!['client_secret'],
//         // confirmPayment: true,
//         // )
//       )
//           .then((newValue) {
//         print('payment intent' + paymentIntentData!['id'].toString());
//         print(
//             'payment intent' + paymentIntentData!['client_secret'].toString());
//         print('payment intent' + paymentIntentData!['amount'].toString());
//         print('payment intent' + paymentIntentData.toString());
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("paid successfully")));
//
//         paymentIntentData = null;
//       }).onError((error, stackTrace) {
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//             content: Text("Cancelled "),
//           ));
//     } catch (e) {
//       print('$e');
//     }
//   }
//
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization':
//                 'Bearer sk_test_51OFgWCSDo2mwB8uzksXm3MT3O7Pd5ejaBustRPdnTKKTGdruHXJXfvMp1LFpGx11cJ8RYg2fQkbhjXKchkkUUFqN00zS6evcM0',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       return jsonDecode(response.body.toString());
//     } catch (e) {
//       print('exception' + e.toString());
//     }
//   }
//
//   calculateAmount(String amount) {
//     final price = int.parse(amount) * 100;
//     return price.toString();
//   }
 }
