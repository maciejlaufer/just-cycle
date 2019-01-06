import 'dart:async';
import 'package:flutter/material.dart';
import './customers_list.dart';
import './app_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals.dart' as globals;
import '../config.dart' as config;
import '../widgets/loader.dart';

class HomePage extends StatefulWidget {
  var cameras;

  HomePage(this.cameras);

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  final String url = config.baseUrl + '/api/stores';
  List shopData = [];
  List searchList = [];
  bool _isLoadingShops = true;

  Future<String> getShopData() async {
    var res = await http.get(
      Uri.encodeFull(url), 
      headers: {
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