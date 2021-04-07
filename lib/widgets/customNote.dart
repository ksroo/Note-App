import 'dart:ui';

import 'package:course_flutter/constants/constants.dart';
import 'package:course_flutter/screens/editScreen.dart';
import 'package:course_flutter/screens/viewNotes.dart';
import 'package:flutter/material.dart';

class CustomNote extends StatefulWidget {
  final Color color;
  final String title;
  final String description;
  final docid;
  CustomNote({this.color, this.title, this.description, this.docid});

  @override
  _CustomNoteState createState() => _CustomNoteState();
}

class _CustomNoteState extends State<CustomNote> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ViewNotes(
                listColor: widget.color,
                listDiescription: widget.description,
                listTitle: widget.title,
              );
            },
          ),
        );
      },
      child: Container(
        height: 400,
        width: 200,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "${widget.title}",
              style: TextStyle(
                  color: mainDarkBlueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(widget.description),
            Padding(
              padding: const EdgeInsets.only(top: 105, left: 150),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditScreen(
                      docid: widget.docid,
                      listTitle: widget.title,
                      listdescription: widget.description,
                    );
                  }));
                },
                icon: Icon(Icons.edit),
                color: mainDarkBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
