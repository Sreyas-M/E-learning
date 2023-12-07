import 'package:elearning/provider/loginprovider.dart';
import 'package:elearning/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Userlogin extends StatelessWidget {
   Userlogin({Key? key}) : super(key: key);

   final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2, top: 100),
              child: Text(
                "Welcome\nBack",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Provider.of<LoginProvider>(context, listen: false).emailController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade600,
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller:
                            Provider.of<LoginProvider>(context, listen: false)
                                .passwordController,
                        obscureText:
                            Provider.of<LoginProvider>(context, listen: false)
                                .secure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .security();
                              },
                              icon:
                                  Provider.of<LoginProvider>(context).secure ==
                                          false
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                            ),
                            fillColor: Colors.grey.shade600,
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                      SizedBox(
                        height: 55,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Provider.of<LoginProvider>(context, listen: false)
                                  .login(
                                email: Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .emailController
                                    .text,
                                password: Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .passwordController
                                    .text,
                                context: context,
                              );
                              Provider.of<LoginProvider>(context, listen: false)
                                  .clearText();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          color: Colors.blue,
                          child: Text(
                            "Login Now",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyRegister()));
                              },
                              child: Text(
                               "Don't have an account?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              )),
                          TextButton(
                              child: Text(
                                "Forgot Password",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black),
                              ),
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.all(10),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.lightBlue),
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 20, 20, 20),
                                              child: Text("An 8 Digit No",
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ],
                                        ));
                                  }))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
