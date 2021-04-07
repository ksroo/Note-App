import '../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomNoteTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: TextField(
        style: TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          fillColor: mainWhiteColor,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: "Search",
          //helperStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainWhiteColor, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainWhiteColor, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.mic),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
