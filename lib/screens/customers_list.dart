import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import '../config.dart' as config;
import '../widgets/loader.dart';

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
  String filter = '';

  String url = config.baseUrl + '/api/stores/' + globals.currentShopId.toString() + '/customers';

  Future<String> getCustomerData() async {
    var res = await http.get(
      Uri.encodeFull(url), 
      headers: { 
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
              onChanged: (String newCustomerName){
                setState((){
                  filter = newCustomerName;
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
                    return filter == null || filter == '' || (customersList[index]['fullName'] != null && customersList[index]['fullName'].toLowerCase().contains(filter)) ? Container(
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
                    ) : Container();
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