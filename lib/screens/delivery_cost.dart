import 'package:flutter/material.dart';

class DeliveryCost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeliveryCostState();
}

class _DeliveryCostState extends State<DeliveryCost>{
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  final double _formDistance = 5.0;
  String _currency = 'Dollars';
  TextEditingController distanceController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';

  @override
  initState() {
    super.initState();
    print('test');
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery cost calculator'),
        backgroundColor: Colors.redAccent
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
          primaryColorLight: Colors.tealAccent
        ),
        child:Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
                Padding( 
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: TextField(
                    controller: distanceController,
                    decoration: InputDecoration(
                      labelText: 'Distance',
                      hintText: 'e.g. 124',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide( color: Colors.redAccent)
                      ),
                      suffixText: 'km'
                    ),
                    keyboardType: TextInputType.number,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                            labelText: 'Order price',
                            hintText: 'e.g. 170',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide( color: Colors.redAccent)
                            ),
                            suffixText: _currency
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container( width: _formDistance*5 ),
                      DropdownButton(
                        items: _currencies.map((String value){
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currency,
                        onChanged: (value){
                          _onDropdownChanged(value);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: _formDistance,
                    bottom: _formDistance
                  ),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.redAccent,
                        textColor: Colors.white,
                        child: Text(
                          'Submit',
                          textScaleFactor: 1.5
                        ),
                        onPressed: (){
                          setState(() {
                            result = _calculateDeliveryPrice();  
                          });
                        },
                      ),
                    ),
                    Container( width: _formDistance*5 ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.grey,
                        textColor: Colors.white,
                        child: Text(
                          'Reset',
                          textScaleFactor: 1.5
                        ),
                        onPressed: (){
                          setState(() {
                            result = _reset();  
                          });
                        },
                      )
                    )
                  ],
                ), 
              ),
              Text(result),
            ],
          ),
        )
      )
    );
  }

  void _onDropdownChanged(String value){
    setState((){
      this._currency = value;
    });
  }

  String _calculateDeliveryPrice(){
    double _distance = double.parse(distanceController.text);
    double _orderPrice = double.parse(priceController.text);
    if(((_currency == 'Dollars' || _currency == 'Euro') && _orderPrice > 1000)
    || ( _currency == 'Pounds' && _orderPrice > 500)){
      return 'Free delivery';
    }
    double _total = _distance * 0.25;
    return 'Your delivery cost is ' + _total.toStringAsFixed(2) + ' ' + _currency + '.';
  }

  String _reset(){
    distanceController.text = '';
    priceController.text = '';
    return '';
  }
}