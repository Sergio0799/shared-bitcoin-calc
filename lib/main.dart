import 'package:flutter/material.dart';

// Import the next two possible screens
import 'package:bitcoin_calculator/screens/USDtoBTC_input_screen.dart';
import 'package:bitcoin_calculator/screens/BTCtoUSD_input_screen.dart';
import 'package:bitcoin_calculator/config/globals.dart';
import 'package:bitcoin_calculator/models/utils/conversionAPI.dart';

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
  //Future<String> futureConversion;

  @override
  void initState() {
    super.initState();
    //futureConversion = BitcoinAPI.fetchDisplay(httpClient);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar holding the title of the app
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF2A900),
        title: Text('Crypto - Calc'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FutureBuilder<String>(
            //   future: futureConversion,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       String rate = snapshot.data;
            //       return Text(rate, key: Key("joke-text"));
            //     } else if (snapshot.hasError) {
            //       return Text("${snapshot.error}");
            //     }}),
          // Button for user to go to USD to BTC converter
          ElevatedButton(
            key: Key("USDtoBTC-button"),
            child: Text(
              "USD to BTC",
              key: Key("USDtoBTC-text"),
              style: TextStyle(
                fontSize: 18,
              )
            ),
            // Style the button's border and size to match desired UI
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              fixedSize: Size(200, 46),
              primary: Color(0xFF68A047)
            ),
            // When pressed takes user to USD to BTC conversion screen
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InputUSDScreen()));
            }
          ),
          // Make space between both conversion buttons
          SizedBox(height: 20),
          // Button for user to go to BTC to USD converter
          ElevatedButton(
            key: Key("BTCtoUSD-button"),
            child: Text(
              "BTC to USD",
              key: Key("BTCtoUSD-text"),
              style: TextStyle(
                fontSize: 18,
              )
            ),
            // Style the button's border and size to match desired UI
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              fixedSize: Size(200, 46),
              primary: Color(0xFFF2A900)
            ),
            //When pressed takes user to BTC to USD conversion screen
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => InputBTCScreen()));
            },
          )
        ],
      )),
    );
  }
}
