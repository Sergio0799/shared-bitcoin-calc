import 'package:flutter/material.dart';

// Import exchange tools classes package
import 'package:bitcoin_calculator/models/exchange_tools.dart';
import 'package:bitcoin_calculator/models/utils/conversionAPI.dart';
import 'package:bitcoin_calculator/config/globals.dart';

class InputUSDScreen extends StatefulWidget {
  @override
  _InputUSDScreen createState() => _InputUSDScreen();
}

class _InputUSDScreen extends State<InputUSDScreen> {
  // Initialize variables:
  // Booleans are used to toggle UI widget displays
  bool _input = false;
  bool _output = false;
  // Output value to be displayed, represents BTC
  double _display = 0.0;
  // Variables to toggle error message displays
  String errorMessage = "";
  bool errorDisplay = false;
  Future<double> futureConversion;
  
  // Initialize text controller
  final inputTextController = TextEditingController();
  // Listener for controller, determines if a number has been input to enable conversion button
  @override
  void initState() {
    super.initState();
    inputTextController.addListener(() {
      final input = inputTextController.text.isNotEmpty;
      setState(() => this._input = input);
      futureConversion = BitcoinAPI.fetchConversion(httpClient);
    });
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
        backgroundColor: Color(0xFF68A047),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFF2A900),
            key: Key('USD-back-button')
          ),
          // Return to previous screen when Back button pressed
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('USD to BTC')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Visibility widget toggles display of BTC output value
            Visibility(
              visible: _output,
              // Display BTC conversion of USD input
              child: Text(
                _display.toString(),
                key: Key('USDtoBTC-output'),
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFFF2A900)
                )
              )
            ),
            // Make space between BTC output & USD text input
            SizedBox(height: 20),
            // Container to format shape and style of TextField
            Container(
              width: 337.0,
              height: 48.0,
              decoration: BoxDecoration(
              border: Border.all(width: 2)),
              // TextField to input USD value
              child: TextField(
                key: Key('USD-textfield'),
                controller: inputTextController,
                // When inputing, the keyboard will only display a numberpad
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: errorDisplay ? errorMessage : null,
                ),
              ),
            ),
            // Make space between USD input & conversion button
            SizedBox(height: 20),
            // Conversion button to display BTC conversion of USD input
            ElevatedButton(
              key: Key('USD-convert-button'),
              child: Text(
                "Convert",
                key: Key('USD-convert-text'),
                style: TextStyle(
                  fontSize: 14
                )
              ),
              // Style the button's border and size to match desired UI
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: Size(200, 46),
                primary: Color(0xFFF2A900)
              ),
              // If user has made an input, then enable button. Otherwise disabled
              onPressed: _input? () {
                setState(() {
                try {
                  // Convert string to double and check that user input a number that is within reason
                  double usd = double.parse(inputTextController.text);
                  errorDisplay = false;
                  if(usd >= 0) {
                    // Pass input USD to converter constructor
                    USDtoBTC usdConversion = USDtoBTC(usd);

                    futureConversion.then((double conversionRate) {
                      _display = usdConversion.conversion(conversionRate);
                    }).catchError((e) {
                      errorMessage = "Couldn't retrieve current exchange rate";
                      errorDisplay = true;
                    });


                    // Set display text to calculated BTC conversion
                    _output = true;

                    //inputTextController.clear();
                  }
                  else {
                    // Display error message if user input is an invalid number
                    _output = false;
                    errorMessage = "Invalid - Negative Number";
                    errorDisplay = true;
                  }
                  // Display error message if user input is not a number, invalid
                } catch (e) {
                  _output = false;
                  errorMessage = "Invalid Input";
                  errorDisplay = true;
                }
                });
              } : null  // Disable button if user has no input
            )
          ]
        )
      )
    );
  }
}