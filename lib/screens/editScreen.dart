import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/constants/constants.dart';
import 'package:course_flutter/constants/showLoading.dart';
import 'package:course_flutter/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class EditScreen extends StatefulWidget {
  final docid;
  final listTitle;
  final listdescription;

  EditScreen({this.docid, this.listTitle, this.listdescription});
  static const routeName = "/EditScreen";

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  Reference ref;

  var title, note;

  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  addNotes(context) async {
    var formdata = fromKey.currentState;

    if (formdata.validate()) {
      showLoaging(context);
      formdata.save();

      await notesref.doc(widget.docid).update({
        "title": title,
        "note": note,
        "userid": FirebaseAuth.instance.currentUser.uid,
      }).then((value) {
        Navigator.of(context).pushNamed(HomePage.routeName);
      }).catchError((e) {
        print("$e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainOrangeColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: mainDarkBlueColor,
        ),
        elevation: 0,
        backgroundColor: mainOrangeColor,
        title: Text(
          "Edit Notes",
          style: TextStyle(
              color: mainDarkBlueColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.listTitle,
                  validator: (val) {
                    if (val.length > 30) {
                      return "Title can't to be larger than 30 letter ";
                    }
                    if (val.length < 2) {
                      return "Title can't to be less than 2 letter ";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    title = val;
                  },
                  maxLength: 30,
                  maxLines: 2,
                  style: TextStyle(
                      color: mainDarkBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: mainWhiteColor, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    helperStyle: TextStyle(color: mainDarkBlueColor),
                    hintText: "Title",
                    hintStyle: TextStyle(
                        color: mainDarkBlueColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.note,
                      color: mainDarkBlueColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainDarkBlueColor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainDarkBlueColor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: widget.listTitle,
                  validator: (val) {
                    if (val.length > 300) {
                      return "Note can't to be larger than 300 letter ";
                    }
                    if (val.length < 10) {
                      return "Note can't to be less than 10 letter ";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    note = val;
                  },
                  maxLength: 300,
                  maxLines: 8,
                  style: TextStyle(
                      color: mainDarkBlueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: mainWhiteColor, fontSize: 16),
                    filled: true,
                    fillColor: Colors.white,
                    helperStyle: TextStyle(color: mainDarkBlueColor),
                    hintText: "Note",
                    hintStyle: TextStyle(
                        color: mainDarkBlueColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    prefixIcon: Icon(
                      Icons.note,
                      color: mainDarkBlueColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainDarkBlueColor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: mainDarkBlueColor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 100, right: 100),
                child: RaisedButton(
                  child: Text(
                    "Edit Note",
                    style: TextStyle(fontSize: 22),
                  ),
                  shape: StadiumBorder(),
                  color: mainDarkBlueColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  textColor: Colors.white,
                  onPressed: () async {
                    await addNotes(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
