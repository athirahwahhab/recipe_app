import 'package:flutter/material.dart';
import 'package:recipes/Screens/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.green[200],
      ),
      home: LoginForm(),
    );
  }
}

