import 'package:flutter/material.dart';

import 'package:bitcoin_calculator/models/exchange_tools.dart';
import 'package:bitcoin_calculator/screens/USDtoBTC_input_screen.dart';
import 'package:bitcoin_calculator/screens/BTCtoUSD_input_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto-Calc'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 
        [
          
          ElevatedButton(
            key: Key("USDtoBTC-button"),
            child: Text(
              "USD to BTC",
              key: Key("USDtoBTC-text"),
              style: TextStyle(
                fontSize: 18,
                //color: Color(0xFF4C7488)
              )
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              fixedSize: Size(280, 46),
              primary: Color(0xFF4C7488)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InputBTCScreen()));}),
          ElevatedButton(
            key: Key("BTCtoUSD-button"),
            child: Text(
              "BTC to USD",
              key: Key("BTCtoUSD-text"),
              style: TextStyle(
                fontSize: 18,
                //color: Color(0xFF4C7488)
              )
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              fixedSize: Size(280, 46),
              primary: Color(0xFF4C7488)
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InputBTCScreen()));
            },
          )
        ],
      )),
    );
  }
}
