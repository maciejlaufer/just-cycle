import 'package:flutter/material.dart';
import './camera.dart';

class CameraScreen extends StatefulWidget {
  var cameras;
  
  CameraScreen(this.cameras);

  @override
  State<StatefulWidget> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.redAccent
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300.0,
              padding: EdgeInsets.all(15.0),
              child: CameraApp(widget.cameras)
            )
          ],
        )
    );
  }

}
