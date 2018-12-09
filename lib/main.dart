import 'package:flutter/material.dart';
import './screens/home_page.dart';

void main() => runApp(new JustCycleApp());

class JustCycleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Just cycle",
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.red,
      )
    );
  }
}