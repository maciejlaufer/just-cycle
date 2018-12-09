import 'package:flutter/material.dart';

class CustomersList extends StatefulWidget {
  final String shopId;
  
  const CustomersList({ 
    Key key, 
    this.shopId
  }): super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  String shopId = null;
  @override
  initState() {
    super.initState();
    this.shopId = widget.shopId;
  }
  String url = 'http://localhost:61331/api/';
  String shopName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery cost calculator'),
        backgroundColor: Colors.redAccent
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search customers... ' + this.shopId
              ),
              onChanged: (String newShopName){
                setState((){
                  shopName = newShopName;
                });
              },
            ),
            Text(shopName)
          ],
        )
      )
    );
  }

}

//   String sayHello(){
//     String hello;
//     hello = "Hello";
//     DateTime now = DateTime.now();
//     int hour = now.hour;
//     int minute = now.minute;
//     if(hour < 12){
//       hello = "Good morning!";
//     } else if(hour < 18){
//       hello = "Good afternoon!";
//     } else {
//       hello = "Good evening!";
//     }
//     String minutes = (minute < 10) ? "0" + minute.toString() : minute.toString();
//     return "It's " + hour.toString() + ":" + minutes + ". \n" + hello;
//   }
// }

// class AlertButton extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     var button = Container( 
//       padding: EdgeInsets.all(5.0),
//       child: RaisedButton(
//         child: Text("Click!"),
//         color: Colors.blue,
//         elevation: 5.0,
//         onPressed: (){
//           displayAlert(context);
//         },
//       )
//     );
//     return button;
//   }
//   void displayAlert(BuildContext context){
//     var alert = AlertDialog(
//       title: Text("Example title"),
//       content: Text("Example content")
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => alert
//     );
//   }
// }
