import 'package:flutter/material.dart';

const textinputDecoration = InputDecoration(


  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(

    borderSide: BorderSide(color: Colors.white38, width: 2 ),


  ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(246,153,6,1), width: 2 ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2 ),
    ),
);

void nextScreen(context, page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}