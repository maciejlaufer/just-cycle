import 'dart:async';
import 'package:flutter/material.dart';
import './customers_list.dart';
import './app_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  var cameras;

  HomePage(this.cameras);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://jsonplaceholder.typicode.com/comments';
  List shopData = null;

  Future<String> getShopData() async {
    var res = await http.get(Uri.encodeFull(url), headers: { 'Accept': 'aplication/json'});
    print(res.body);
    setState(() {
      shopData = json.decode(res.body);
    });
    return 'Success!';
  }

  @override
  initState() {
    super.initState();
    this.getShopData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          drawer: AppDrawer(widget.cameras),
          appBar: AppBar(
            title: Text('Just cycle'),
            backgroundColor: Colors.redAccent,
          ),
          body: ListView.builder(
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
                            padding: EdgeInsets.all(15.0),
                            child: Text(shopData[index]['name']),
                          ),
                        ),
                        onTap: (){
                          final snackBar = SnackBar(content: Text(shopData[index]['id'].toString()));
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      )
                    ],
                  )
                )
              );
            }
          ),
        );
  }
}