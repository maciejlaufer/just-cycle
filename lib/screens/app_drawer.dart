import 'package:flutter/material.dart';
import './other_page.dart';
import './delivery_cost.dart';
import './customers_list.dart';
import './camera_screen.dart';
import '../globals.dart' as globals;

class AppDrawer extends StatefulWidget {
  var cameras;

  AppDrawer(this.cameras);

  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer>{

  //String currentShopName = globals.;
  String currentShopEmail = "";
  String shopIcon = "http://icon.touch-slide.jp/wp/wp-content/uploads/2012/07/s00037.jpg";
  String otherShopIcon = "https://t4.ftcdn.net/jpg/02/03/64/45/160_F_203644567_gkgQ5jfHL6q6PP7lAMHdS8IR3Pu2urSQ.jpg";
  bool isShopChoosed = true;

  void changeCurrentShopIcon(){
    var temp = shopIcon;
    this.setState(() {
      shopIcon = otherShopIcon;
      otherShopIcon = temp;
    });
  }

  void getNextShop(){
    changeCurrentShopIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: this.isShopChoosed ? GestureDetector(
              onTap: () => changeCurrentShopIcon(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(shopIcon),
              ),
            ) : Container(),
            otherAccountsPictures: this.isShopChoosed ? <Widget>[
              GestureDetector(
                onTap: () => getNextShop(),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(otherShopIcon),
                ),
              ),
            ] : <Widget>[],
            accountName: this.isShopChoosed ? Text(globals.currentShopName) : Container(),
            accountEmail: this.isShopChoosed ? Text(currentShopEmail) : Container(),
            decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                image: AssetImage('images/bike.png')
              )
            ),
          ),
          ListTile(
            title: Text("Customers list"),
            trailing: Icon(Icons.arrow_right),
            onTap: () { 
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => CustomersList(shopId: globals.currentShopId)));
            },
          ),
          ListTile(
            title: Text("Delivery cost calculator"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => DeliveryCost()));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Other page"),
            trailing: Icon(Icons.arrow_right),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => OtherPage('Other page')));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Camera"),
            trailing: Icon(Icons.camera_alt),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute( builder: (BuildContext context) => CameraScreen(widget.cameras)));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Close"),
            trailing: Icon(Icons.cancel),
            onTap: () => Navigator.of(context).pop()
          )
        ],
      )
    );
  }

}


class BikeImageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage bikeAsset = new AssetImage('images/bike.png');
    Image image = new Image(image: bikeAsset, width: 50.0, height: 50.0);
    return Container(
      child: image,
      padding: EdgeInsets.only(right: 10.0),
    );
  }
}