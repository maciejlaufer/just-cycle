import 'package:flutter/material.dart';

class AlertButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var button = Container( 
      padding: EdgeInsets.all(5.0),
      child: RaisedButton(
        child: Text("Click!"),
        color: Colors.blue,
        elevation: 5.0,
        onPressed: (){
          displayAlert(context);
        },
      )
    );
    return button;
  }
  void displayAlert(BuildContext context){
    var alert = AlertDialog(
      title: Text("Example title"),
      content: Text("Example content")
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert
    );
  }
}
