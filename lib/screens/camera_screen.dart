import 'package:flutter/material.dart';
import '../widgets/camera.dart';

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
              padding: EdgeInsets.all(15.0),
              child: CameraApp(widget.cameras)
            )
          ],
        )
    );
  }

}
