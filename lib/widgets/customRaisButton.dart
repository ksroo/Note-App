import '../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomRaisButtom extends StatelessWidget {
  final String text;
  final Function onPressed;
  CustomRaisButtom({this.text,this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 100, right: 100),
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24),
            ),
            CircleAvatar(
              backgroundColor: mainWhiteColor,
              child: Icon(
                Icons.arrow_forward,
                color: mainOrangeColor,
              ),
            ),
          ],
        ),
        shape: StadiumBorder(),
        color: mainOrangeColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        textColor: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
