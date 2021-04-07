import 'package:course_flutter/screens/loginScreen.dart';

import '../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  final String text, inkwellText;
  final Function onTap;

  CustomInputText({this.inkwellText, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: mainWhiteColor, fontSize: 18),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              inkwellText,
              style: TextStyle(color: mainOrangeColor, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
