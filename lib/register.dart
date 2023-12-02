import 'dart:io';
import 'package:elearning/provider/registerprovider.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class MyRegister extends StatelessWidget {
MyRegister({Key? key}) : super(key: key);

final formKeyreg = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Provider.of<RegisterProvider>(context, listen: false).image != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 145, left: 250),
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(
                            Provider.of<RegisterProvider>(context,
                                    listen: false)
                                .image!
                                .path))),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 145, left: 250),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCsjjmwwnCK8jwtLh-XmBuXLIGc59lEnooYw&usqp=CAU"),
                    ),
                  ),
            Container(
              padding: EdgeInsets.only(left: 50, top: 100),
              child: Text("Create Your\nAccount",
                  style: TextStyle(color: Colors.white, fontSize: 40)),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35,
                    right: 35,
                    left: 35),
                child: Form(
                  key:formKeyreg,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Provider.of<RegisterProvider>(context,
                                listen: false)
                            .name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: Provider.of<RegisterProvider>(context,
                                listen: false)
                            .email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: Provider.of<RegisterProvider>(context,
                                listen: false)
                            .pass,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade600,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: Provider.of<RegisterProvider>(context,
                                listen: false)
                            .phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          // You can add more phone number validation logic here if needed.
                          return null;
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Phone",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromARGB(255, 60, 170, 223),
                            child: IconButton(
                                onPressed: () {
                                  Provider.of<RegisterProvider>(context,
                                          listen: false)
                                      .addUser(context,formKeyreg);
                                },
                                icon: Icon(
                                  Icons.coronavirus_rounded,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Userlogin()));
                              },
                              child: Text(
                                "Already have an Account?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 470,
                left: 310,
                child: IconButton(
                    onPressed: () {
                      showImagePickerOption(context);
                    },
                    icon: const Icon(Icons.add_a_photo)))
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Provider.of<RegisterProvider>(context, listen: false)
                            .pickImageFromgallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Provider.of<RegisterProvider>(context, listen: false)
                            .pickImageFromcamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
