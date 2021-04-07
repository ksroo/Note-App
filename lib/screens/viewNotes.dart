import 'package:course_flutter/constants/constants.dart';
import 'package:course_flutter/screens/editScreen.dart';
import 'package:flutter/material.dart';

class ViewNotes extends StatefulWidget {
  final listTitle;
  final listDiescription;
  final listColor;

  ViewNotes({this.listTitle, this.listColor, this.listDiescription});

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: mainDarkBlueColor,
          ),
          elevation: 0,
          backgroundColor: widget.listColor,
        ),
        backgroundColor: widget.listColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Text(
                  " ${widget.listTitle}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "${widget.listDiescription}",
                  style: TextStyle(color: mainDarkBlueColor, fontSize: 18),
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
            Navigator.of(context).pushNamed(EditScreen.routeName);
          },
          child: Icon(
            Icons.edit,
            size: 30,
          ),
        ),
      ),
    );
  }
}
