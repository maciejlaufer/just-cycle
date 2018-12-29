import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'loader.dart';

class CustomersList extends StatefulWidget {
  final int shopId;
  
  const CustomersList({ 
    Key key, 
    this.shopId
  }): super(key: key);
  @override
  State<StatefulWidget> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  int shopId = null;
  String shopName = '';
  bool _isLoadingCustomers = true;
  List customersList = [];

  String url = 'http://192.168.1.11:61331/api/stores/' + globals.currentShopId.toString() + '/customers';

  Future<String> getCustomerData() async {
    var res = await http.get(
      Uri.encodeFull(url), 
      headers: { 
        'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsInVuaXF1ZV9uYW1lIjoiYWRtaW4iLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjYxMzMxIiwiaWF0IjoxNTQ1OTgyNzY2LCJuYmYiOjE1NDU5ODI3NjYsImV4cCI6MTU0NjI0MTk2NiwianRpIjoiMDBiZjU0MTZkNmM4NDYyNjgwNjM4OGY4NjZhZGJiZjMifQ.Y43xCNQStRkQZExAOu18fRR4-1lxMlOsKRBpNAOU-d8hjd7Bpl6BAXhaH-M6aYHCiA_kWmfGiMfbJrhULXMcr3i7hoc4qKxmnDlQjUm_lEvKEBnUo7yt6boGd1ZmLxf3M41P1wYLAS4tP_W7wlELioI0C7WFQmAR_8lC_zoo_BXpSSaF80kqtpgoNRYTaxEM13QMRC2Ohy5iA2UTppFYwfEyFUusDJWDWLPrQy02YvtX4-aOzhY4Fmthbwa2-0shmOyhE7SV4oDKvG30_bt9HZsjkpkI3VH0ritje81fw2XlJty8NAUOTDgxe2UkbBFV0X842fv6e7mZZPzueBmlMA',
        'Accept': 'aplication/json',
      }
    );
    if (res == null || res.statusCode != 200)
        throw new Exception('HTTP request failed, statusCode: ${res?.statusCode}, $url');
    setState(() { 
      customersList = json.decode(res.body);
      _isLoadingCustomers = false;
    });
    return 'Success!';
  }

  Future<Null> _refresh() async {
    await getCustomerData();
    return null;
  }

  @override
  initState() {
    super.initState();
    this.shopId = widget.shopId;
    this.getCustomerData().then((success){

    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(globals.currentShopName),
        backgroundColor: Colors.redAccent
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search customers... '
              ),
              onChanged: (String newShopName){
                setState((){
                  shopName = newShopName;
                });
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: _isLoadingCustomers ? Center(child: FlipLoader()) : RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: _refresh,
                  child: ListView.builder(
                  itemCount: this.customersList == null ? 0 : this.customersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            GestureDetector(
                              child: Card(
                                child: Container(
                                  child: ListTile(
                                    title: Text(customersList[index]['fullName'] == null ? 'brak' : customersList[index]['fullName']),
                                  )
                                ),
                              ),
                              onTap: (){
                                
                              }
                            )
                          ],
                        )
                      )
                    );
                  }),
                )
              )
            )
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
