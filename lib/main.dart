import 'package:flutter/material.dart';
import './screens/home.dart';

void main() => runApp(new JustCycleApp());

class JustCycleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Just cycle",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Just cycle title"),
          ),
          body: Home(),
        ));
  }
}
