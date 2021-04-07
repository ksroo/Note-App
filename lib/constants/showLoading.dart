import '../constants/constants.dart';
import 'package:flutter/material.dart';


 showLoaging(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
            color: mainRedColors,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }