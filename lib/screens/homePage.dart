import 'package:course_flutter/widgets/customNote.dart';

import '../../screens/addNotes.dart';
import 'dart:math';
import '../../widgets/custonNoteTextField.dart';

import '../../constants/constants.dart';
import '../../screens/loginScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  static const routeName = "/HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  List itemsColor = [
    mainBlueColors,
    mainGreenColors,
    mainYellowColors,
    mainRedColors,
    mainBlueColors,
    mainGreenColors,
    mainYellowColors,
    mainRedColors,
  ];

  // للحصول علي معلومات المستخدم
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainOrangeColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            //  تسجيل الخروج من التطبيق
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          icon: Icon(
            Icons.exit_to_app,
            color: mainDarkBlueColor,
            size: 30,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "My Notes",
              style: TextStyle(
                  color: mainDarkBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          CustomNoteTextField(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: notesref
                    .where("userid",
                        isEqualTo: FirebaseAuth.instance.currentUser.uid)
                    .get(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return GridView.builder(
                      itemCount: snapShot.data.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        int min = 0;
                        int max = itemsColor.length;
                        Random rnd = new Random();
                        int randomNumber = min + rnd.nextInt(max - min);
                          
                        return Dismissible(

                            onDismissed: (direction) async {
                              await  notesref
                                  .doc(snapShot.data.docs[index].id)
                                  .delete();
                            },
                            key: UniqueKey(),
                            child: CustomNote(
                              color: itemsColor[randomNumber],
                              title: "${snapShot.data.docs[index]['title']}",
                              description:
                                  "${snapShot.data.docs[index]['note']}",
                              docid: snapShot.data.docs[index].id,
                            ));
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainDarkBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddNotes.routeName);
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

// GridView.builder(
//                       itemCount: itemsColor.length,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 10,
//                         crossAxisSpacing: 10,
//                       ),
//                       itemBuilder: (context, index) {
//                         return CustomNote(
//                           color: itemsColor[index]["color"],
//                         );
//                       },
//                     );

//
// "${snapShot.data.docs[index].data()['title']}",

// Container(
//                           height: 100,
//                           width: 100,
//                           color: itemsColor[randomNumber],
//                           child: Text("${snapShot.data.docs[index]['title']}"),
//                         );
