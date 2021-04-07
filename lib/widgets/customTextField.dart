import '../constants/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labeltext;
  final bool obscureText;
  final Function onSaved;
  final Widget prefixIcon;

  CustomTextField({
    this.labeltext,
   this.obscureText,
    this.prefixIcon,
    this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
        validator: (val) {
          if (val.isEmpty) {
            return "error enter";
          }
        },
        style: TextStyle(color: mainWhiteColor, fontSize: 18),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: mainWhiteColor),
          helperStyle: TextStyle(color: mainWhiteColor),
          labelText: labeltext,
          labelStyle: TextStyle(color: mainWhiteColor, fontSize: 20),
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainWhiteColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),

          //filled: true,
          //fillColor: Colors.red,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
