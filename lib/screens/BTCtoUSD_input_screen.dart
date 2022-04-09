import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/models/exchange_tools.dart';
import 'package:bitcoin_calculator/main.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/models/utils/conversionAPI.dart';
import 'package:bitcoin_calculator/config/globals.dart';

class InputBTCScreen extends StatefulWidget {
  @override
  _InputBTCScreen createState() => _InputBTCScreen();
}

class _InputBTCScreen extends State<InputBTCScreen> {
  //initialized all used variables:

  //boolean vars for the changing state of widgets
  bool _input = false;
  bool _output = false;
  //diaply and error vars to see valid input and error detection in user input
  double _display = 0.0;
  String errorMessage = "";
  bool errorDisplay = false;
  Future<double> futureConversion;
  
  
  // Initialize text controller
  final inputTextController = TextEditingController();
  // Listener for controller, determines if a number has been input to enable Continue button
  @override
  void initState() {
    super.initState();
    inputTextController.addListener(() {
      final input = inputTextController.text.isNotEmpty;
      setState(() => this._input = input);
    });
    futureConversion = BitcoinAPI.fetchConversion(httpClient);
  }

  // Stop listening for controller when disposed
  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }

  @override
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      // Completely transparent AppBar has Back button in top left
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFF2A900),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF68A047),
            key: Key('BTC-back-button')
          ),
          // Return to previous screen when Back button pressed
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('BTC to USD')
      ),
      body: Center(
        child: Column(
          //Output for conversion widget
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _output,
              child: Text(
                _display.toString(),
                key: Key('BTCtoUSD-output'),
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF68A047)
                )
              )
            ),
            // Making space between
            SizedBox(height: 20),
            //Container for BTC input 
            Container(
                width: 337.0,
                height: 48.0,
                decoration: BoxDecoration(
                border: Border.all(width: 2)),

              child: TextField(
                key: Key('BTC-textfield'),
                controller: inputTextController,
                // When inputing, the keyboard will only display a numberpad
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: errorDisplay ? errorMessage : null
                )
              )
            ),
            // Making space between 
            SizedBox(height: 20),
            ElevatedButton(
              key: Key('BTC-convert-button'),
              child: Text(
                
                "Convert",
                key: Key('BTC-convert-text'),
                style: TextStyle(
                  fontSize: 14,

                )
              ),
              // Style the button's border and size to match  UI
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: Size(200, 46),
                primary: Color(0xFF68A047)
              ),
              // If user has made an input, then enable button. Otherwise disabled
              onPressed: _input? () {
                setState(() {
                try {
                  // Reads users response to determine its validity
                  double BTC = double.parse(inputTextController.text);
                  errorDisplay = false;
                  if(BTC >= 0) {
                    // Store number of BTCtoUSD input 
                    BTCtoUSD BTCConversion = BTCtoUSD(BTC);

                    futureConversion.then((double conversionRate) {
                      _display = BTCConversion.conversion(conversionRate);
                    }).catchError((e) {
                      errorMessage = "Couldn't retrieve current exchange rate";
                      errorDisplay = true;
                    });
                    
                    _output = true;
                  }
                  else {
                    _output = false;
                    errorMessage = "Invalid - Negative Number";
                    errorDisplay = true;
                  }
                } catch (e) {
                  _output = false;
                  errorMessage = "Invalid Input";
                  errorDisplay = true;
                }
                });
              } : null
            )
          ]
        )
      )
    );
  }
}