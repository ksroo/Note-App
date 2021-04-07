import 'package:course_flutter/constants/constants.dart';
import 'package:course_flutter/screens/addNotes.dart';
import 'package:course_flutter/screens/editScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/homePage.dart';

import '../screens/loginScreen.dart';

import '../screens/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

bool isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
  } else {
    isLogin = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
            headline5: TextStyle(
                color: mainDarkBlueColor,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      home: isLogin == false ? LoginScreen() : HomePage(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        AddNotes.routeName: (ctx) => AddNotes(),
        EditScreen.routeName: (ctx) => EditScreen(),
      },
    );
  }
}
