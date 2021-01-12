import 'package:flutter/material.dart';

import 'app_flow/app_flow.dart';
import 'app_intro/welcome_screen.dart';
import 'constants.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hackathon',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AppFlow(),
    );
  }
}
