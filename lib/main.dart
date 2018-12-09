import 'dart:async';
import 'package:flutter/material.dart';
import './screens/home_page.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async { 
  cameras = await availableCameras();
  runApp(new JustCycleApp()); 
}

class JustCycleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Just cycle",
      home: HomePage(cameras),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent,
        accentColor: Colors.red,
      )
    );
  }
}