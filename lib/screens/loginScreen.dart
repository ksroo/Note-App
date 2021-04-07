import 'package:awesome_dialog/awesome_dialog.dart';
import '../constants/showLoading.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/signupScreen.dart';

import '../widgets/customInputText.dart';
import '../widgets/customRaisButton.dart';

import '../constants/constants.dart';
import '../widgets/customTextField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/LoginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var myemail, mypassword;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

 

  signIn() async {
    var fromData = formKey.currentState;

    if (fromData.validate()) {
      fromData.save();
      try {
       // showLoaging(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myemail,
          password: mypassword,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
         // Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("No user found for that email."),
          )..show();
        } else if (e.code == 'wrong-password') {
        //  Navigator.of(context).pop();
          AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Wrong password provided for that user."),
          )..show();
        }
      }
    } else {
      print("Not vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainDarkBlueColor,
      body: Form(
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
            //// inputtext
            CustomInputText(
              text: "if you no have Account ",
              inkwellText: "SignUp",
              onTap: () {
                Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomRaisButtom(
              text: "LogIn",
              onPressed: () async {
                var user = await signIn();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
