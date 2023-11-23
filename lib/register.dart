import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:elearning/bottom_nav.dart';
import 'package:elearning/picking.dart';
import 'package:elearning/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  addUser(BuildContext context ) async {
    final uri=Uri.parse("http://192.168.43.135/php/elearn/api/adduserapi.php");
    var request=http.MultipartRequest("POST",uri);
    request.fields["firstname"]=name.text;
    request.fields["email"]=email.text;
    request.fields["phone"]=phone.text;
    request.fields["password"]=pass.text;
    var pic=await http.MultipartFile.fromPath("photo",_image!.path);
    request.files.add(pic);
    var response=await request.send();
    if(response.statusCode==200){
      print("Sucess");
      Fluttertoast.showToast(msg: "Registered");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Userlogin(),));
    }else{
      Fluttertoast.showToast(msg: "Failed");
    }
  }



  File? file;
  XFile? _image;
  File? selectedIMage;
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
            _image != null
                ? Padding(
                  padding: const EdgeInsets.only(top: 145,left: 250),
                  child: CircleAvatar(
                      radius: 50, backgroundImage: FileImage(File(_image!.path))),
                )
                : Padding(
                  padding: const EdgeInsets.only(top: 145,left: 250),
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
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
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
                      controller: email,
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
                      controller: pass,
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
                      controller: phone,
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
                                addUser(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BaseScreen()));
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
                        pickImageFromgallery();
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
                        pickImageFromcamera();
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

//Gallery
  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }
  //Camera
  pickImageFromcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      setState(() {
        _image = xFile;
      });
    }
  }}