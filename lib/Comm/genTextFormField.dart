import 'package:flutter/material.dart';

import 'comHelper.dart';

class getTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;
  bool isEnable;
  Color hintColor = Colors.green;

  getTextFormField(
      {
        required this.controller,
        required this.hintName,
        required this.icon,
        this.isObscureText = false,
        this.inputType = TextInputType.text,
        this.isEnable = true,
      });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          if (hintName == "Email" && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.green),
          ),
          prefixIcon: Icon(icon),
          hintText: hintName,
          labelText: hintName,
          hintStyle: TextStyle(color: hintColor),
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}