import 'package:flutter/material.dart';

import 'package:bitcoin_calculator/models/exchange_tools.dart';
import 'package:bitcoin_calculator/main.dart';

class InputUSDScreen extends StatefulWidget {
  @override
  _InputUSDScreen createState() => _InputUSDScreen();
}

class _InputUSDScreen extends State<InputUSDScreen> {
  bool _input = false;
  double _display = 0.0;
  String errorMessage = "";
  bool errorDisplay = false;
  
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF4C748B),
            key: Key('USD-back-button')
          ),
          // Return to previous screen when Back button pressed, keeps context of Homebrew instance
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: _input,
              child: Text(
                _display.toString(),
                key: Key('USDtoBTC-output'),

              )
            ),
            Container(
                width: 300.0,
                height: 48.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 2)
                  
                ),
                
              child: TextField(
                key: Key('USD-textfield'),
                controller: inputTextController,
                // When inputing, the keyboard will only display a numberpad
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: InputBorder.none),
                
              ),
            ),
            Container(
              height: 48,
              width: 337,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF4C748B),
                  width: 2
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(10.0),
              // TextField for user to input the number of cups of coffee they would like
              child: TextField(
                key: Key('cups-textfield'),
                controller: inputTextController,
                // When inputing, the keyboard will only display a numberpad
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: InputBorder.none)
              )
            ),
            ElevatedButton(
              key: Key('USD-input-button'),
              child: Text(
                // Display "Continue" within button in Montserrat font, 14px
                "GO",
                key: Key('USD-go-text'),
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat'
                )
              ),
              // Style the button's border and size to match desired UI
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                fixedSize: Size(280, 46),
                primary: Color(0xFF4C748B)
              ),
              // If user has made an input, then enable button. Otherwise disabled
              onPressed: _input? () {
                try {
                  // Convert string to int and check that user input a number that is within reason
                  double usd = double.parse(inputTextController.text);
                  if(usd > 0) {
                    // Store number of cups input in Homebrew instance
                    BTCtoUSD usdConversion = BTCtoUSD(usd);
                    //
                    _display = usdConversion.conversion();
                  }
                  else {
                    errorMessage = "Value is negative, invalid";
                    errorDisplay = true;
                  }
                } catch (e) {
                  errorMessage = "Value invalid";
                  errorDisplay = true;
                }
              } : null
            )
          ]
        )
      )
    );
  }
}