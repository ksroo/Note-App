import '../constants/constants.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  
  final Function onSaved;

  PasswordTextField({
   
    this.onSaved,
  });
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isHidden = true;
  String labelText = "Password";

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          validator: (val) {
                    if (val == null) {
                      return "Password can't be larger than 100 letter";
                    }
                    return null;
                  },
        onSaved: widget.onSaved,
        obscureText: labelText == "Password" ? _isHidden : false,
        style: TextStyle(color: mainWhiteColor, fontSize: 18),
        decoration: InputDecoration(
          errorStyle: TextStyle(color: mainWhiteColor),
          helperStyle: TextStyle(color: mainWhiteColor),
          labelText: labelText,
          labelStyle: TextStyle(color: mainWhiteColor, fontSize: 20),
          prefixIcon: Icon(
            Icons.lock,
            color: mainWhiteColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainWhiteColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainWhiteColor, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: labelText == "Password"
              ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden
                      ? Icon(
                          Icons.visibility_off,
                          color: mainWhiteColor,
                        )
                      : Icon(
                          Icons.visibility,
                          color: mainWhiteColor,
                        ),
                )
              : null,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
