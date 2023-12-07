import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../login.dart';

class RegisterProvider extends ChangeNotifier{
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();
  XFile? image;
  bool secure = true;


  addUser(BuildContext context , fkey) async {
    if (fkey.currentState?.validate() ?? false) {
      final uri = Uri.parse("http://192.168.43.135/php/elearn/api/adduserapi.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields["firstname"] = name.text;
      request.fields["email"] = email.text;
      request.fields["phone"] = phone.text;
      request.fields["password"] = pass.text;

      var pic = await http.MultipartFile.fromPath("photo", image!.path);
      request.files.add(pic);

      var response = await request.send();
      if (response.statusCode == 200) {
        print("Success");
        Fluttertoast.showToast(msg: "Registered");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Userlogin(),));
      } else {
        Fluttertoast.showToast(msg: "Failed");
      }
    }
    notifyListeners();
  }
  //Gallery
  pickImageFromgallery() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
        image = xFile;
    }
    notifyListeners();
  }
  //Camera
  pickImageFromcamera() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
        image = xFile;
    }
    notifyListeners();
  }

  void security(){
    secure = !secure;
    notifyListeners();
  }

  void ClearFullReg(){
    name.clear();
    email.clear();
    pass.clear();
    phone.clear();
    notifyListeners();
  }
}

