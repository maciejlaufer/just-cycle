import 'dart:async';
import 'package:flutter/material.dart';
import './customers_list.dart';
import './app_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart' as globals;
import 'loader.dart';

class HomePage extends StatefulWidget {
  var cameras;

  HomePage(this.cameras);

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final String url = 'http://10.4.255.118:61331/api/stores';
  List shopData = [];
  List searchList = [];
  bool _isLoadingShops = true;

  Future<String> getShopData() async {
    var res = await http.get(
      Uri.encodeFull(url), 
      headers: { 
        'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbiIsInVuaXF1ZV9uYW1lIjoiYWRtaW4iLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjYxMzMxIiwiaWF0IjoxNTQ1OTgyNzY2LCJuYmYiOjE1NDU5ODI3NjYsImV4cCI6MTU0NjI0MTk2NiwianRpIjoiMDBiZjU0MTZkNmM4NDYyNjgwNjM4OGY4NjZhZGJiZjMifQ.Y43xCNQStRkQZExAOu18fRR4-1lxMlOsKRBpNAOU-d8hjd7Bpl6BAXhaH-M6aYHCiA_kWmfGiMfbJrhULXMcr3i7hoc4qKxmnDlQjUm_lEvKEBnUo7yt6boGd1ZmLxf3M41P1wYLAS4tP_W7wlELioI0C7WFQmAR_8lC_zoo_BXpSSaF80kqtpgoNRYTaxEM13QMRC2Ohy5iA2UTppFYwfEyFUusDJWDWLPrQy02YvtX4-aOzhY4Fmthbwa2-0shmOyhE7SV4oDKvG30_bt9HZsjkpkI3VH0ritje81fw2XlJty8NAUOTDgxe2UkbBFV0X842fv6e7mZZPzueBmlMA',
        'Accept': 'aplication/json',
      }
    );
    if (res == null || res.statusCode != 200)
        throw new Exception('HTTP request failed, statusCode: ${res?.statusCode}, $url');
    //print(res.body);
    setState(() {
      shopData = json.decode(res.body);
      searchList = json.decode(res.body);
      _isLoadingShops = false;
    });
    return 'Success!';
  }

  Future<Null> _refresh() async {
    await getShopData();
    return null;
  }

  @override
  initState() {
    super.initState();
    this.getShopData().then((success){
      globals.currentShopName = this.shopData[0]['name'];
      globals.currentShopId = this.shopData[0]['id'];
    });
  }
  
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: AppDrawer(widget.cameras),
          appBar: AppBar(
            title: Text('Just cycle'),
            backgroundColor: Colors.redAccent,
          ),
          body: _isLoadingShops ? Center(child: FlipLoader()) : RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: ListView.builder(
            itemCount: this.shopData == null ? 0 : this.shopData.length,
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
                              title: Text(searchList[index]['name']),
                              trailing: searchList[index]['id'] == globals.currentShopId 
                              ? Icon(Icons.check_box)
                              : Icon(Icons.check_box_outline_blank)
                            )
                          ),
                        ),
                        onTap: (){
                          globals.currentShopName = this.searchList[index]['name'];
                          globals.currentShopId = this.searchList[index]['id'];
                          setState(() {});
                        }
                      )
                    ],
                  )
                )
              );
            }),
          )
        );
  }
}