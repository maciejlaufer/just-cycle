import 'package:flutter/material.dart';
import '../widgets/alert.dart';

class OtherPage extends StatelessWidget{

  final String pageText;

  OtherPage(this.pageText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageText)
      ),
      body: Center(
        child: AlertButton(),
      )
    );
  }

}