
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_flutter/constants/constants.dart';
import 'package:course_flutter/constants/showLoading.dart';
import 'package:course_flutter/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

class AddNotes extends StatefulWidget {
  static const routeName = "/AddNotes";

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");
  Reference ref;
  // File file;
  var title, note;

  GlobalKey<FormState> fromKey = GlobalKey<FormState>();

  addNotes(context) async {
    // if (file == null) {
    //   return AwesomeDialog(
    //           context: context,
    //           title: "important",
    //           body: Text("Please choose image"),dialogType: DialogType.ERROR)
    //       ..show();
    // }
    var formdata = fromKey.currentState;

    if (formdata.validate()) {
      showLoaging(context);
      formdata.save();

      //await ref.putFile(file);

      // imageUrl = await ref.getDownloadURL();
       await notesref.add({
        "title": title,
        "note": note,
        "userid": FirebaseAuth.instance.currentUser.uid,
        // "imageurl": imageUrl,
      });
      Navigator.of(context).pushNamed(HomePage.routeName);
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
          "Add Notes",
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
                    "Add Note",
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
              // Container(
              //   margin: EdgeInsets.only(left: 100, right: 100),
              //   child: RaisedButton(
              //     child: Text(
              //       "Add Image",
              //       style: TextStyle(fontSize: 22),
              //     ),
              //     shape: StadiumBorder(),
              //     color: mainDarkBlueColor,
              //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              //     textColor: Colors.white,
              //     onPressed: () {
              //       showBottomSheet(context);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // showBottomSheet(context) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           color: mainOrangeColor,
  //           padding: EdgeInsets.all(20),
  //           height: 180,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "Please Choose Image",
  //                 style: TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold,
  //                     color: mainDarkBlueColor),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   var picker = await ImagePicker()
  //                       .getImage(source: ImageSource.gallery);
  //                   if (picker != null) {
  //                     file = File(picker.path);
  //                     var rand = Random().nextInt(100000);
  //                     var nameImage = "$rand" + basename(picker.path);

  //                     ref = FirebaseStorage.instance
  //                         .ref("images")
  //                         .child("$nameImage");
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding: EdgeInsets.all(10),
  //                     child: Row(
  //                       children: [
  //                         Icon(Icons.photo_outlined,
  //                             size: 30, color: mainDarkBlueColor),
  //                         SizedBox(width: 20),
  //                         Text(
  //                           "From Gallery",
  //                           style: TextStyle(
  //                               fontSize: 20, color: mainDarkBlueColor),
  //                         )
  //                       ],
  //                     )),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   var picker = await ImagePicker()
  //                       .getImage(source: ImageSource.camera);
  //                   if (picker != null) {
  //                     file = File(picker.path);
  //                     var rand = Random().nextInt(100000);
  //                     var nameImage = "$rand" + basename(picker.path);

  //                     ref = FirebaseStorage.instance
  //                         .ref("images")
  //                         .child("$nameImage");
  //                     Navigator.of(context).pop();
  //                   }
  //                 },
  //                 child: Container(
  //                     width: double.infinity,
  //                     padding: EdgeInsets.all(10),
  //                     child: Row(
  //                       children: [
  //                         Icon(Icons.camera,
  //                             size: 30, color: mainDarkBlueColor),
  //                         SizedBox(width: 20),
  //                         Text(
  //                           "From Camera",
  //                           style: TextStyle(
  //                               fontSize: 20, color: mainDarkBlueColor),
  //                         )
  //                       ],
  //                     )),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
