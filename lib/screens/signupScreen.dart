import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/constants/showLoading.dart';
import 'package:course_flutter/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/passwordTextField.dart';

import '../screens/loginScreen.dart';

import '../widgets/customInputText.dart';

import '../widgets/customRaisButton.dart';

import '../widgets/customTextField.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = "/SignUpScreen";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TextEditingController _emailcontroller = TextEditingController();

  var myusername, myemail, mypassword;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signUp() async {
    var fromData = formKey.currentState;
    if (fromData.validate()) {
      fromData.save();
      try {
        //showLoaging(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: myemail,
          password: mypassword,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
         // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("The password provided is too weak."),
          )..show();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          //Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("The account already exists for that email."),
          )..show();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkBlueColor,
      body: SingleChildScrollView(
              child: Container(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Text(
                    "Note APp",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: mainWhiteColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: CustomTextField(
                    onSaved: (val) {
                      myusername = val;
                    },
                    labeltext: "UserName",
                    prefixIcon: Icon(
                      Icons.person,
                      color: mainWhiteColor,
                    ),
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: CustomTextField(
                    onSaved: (val) {
                      myemail = val;
                    },
                    labeltext: "Email",
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: mainWhiteColor,
                    ),
                    obscureText: false,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: CustomTextField(
                    onSaved: (val) {
                      mypassword = val;
                    },
                    labeltext: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: mainWhiteColor,
                    ),
                    obscureText: true,
                  ),
                ),
                CustomInputText(
                  text: "if you have Account ",
                  inkwellText: "LogIn",
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomRaisButtom(
                  onPressed: () async {
                    UserCredential respons = await signUp();
                    print("==========================");
                    if (respons != null) {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .add({
                            "username": myusername,
                            "email": myemail,
                          });
                      Navigator.pushReplacementNamed(context, HomePage.routeName);
                    } else {
                      print("signUp Field");
                    }
                    print("==========================");
                  },
                  text: "SignUp",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
