import 'package:flutter/material.dart';
import 'package:genai_v2/view/homepage.dart';
import 'view/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NBA 賽事',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(), // 改
      //home: HomePage(),
    );
  }
}
