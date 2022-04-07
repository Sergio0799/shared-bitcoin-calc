import 'package:flutter/material.dart';

import 'package:bitcoin_calculator/models/exchange_tools.dart';

class InputUSDScreen extends StatefulWidget {
  @override
  _InputUSDScreen createState() => _InputUSDScreen();
}

class _InputUSDScreen extends State<InputUSDScreen> {
  bool _input = false;
  bool _output = false;
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
              visible: _output,
              child: Text(
                _display.toString(),
                key: Key('USDtoBTC-output'),
                style: TextStyle(
                  fontSize: 28,
                )
              )
            ),
            // Make space between 
            SizedBox(height: 20),
            Container(
                width: 337.0,
                height: 48.0,
                decoration: BoxDecoration(
                border: Border.all(width: 2)),
                
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
            // Make space between
            SizedBox(height: 20),
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
                fixedSize: Size(200, 46),
                primary: Color(0xFF4C748B)
              ),
              // If user has made an input, then enable button. Otherwise disabled
              onPressed: _input? () {
                setState(() {
                try {
                  // Convert string to int and check that user input a number that is within reason
                  double usd = double.parse(inputTextController.text);
                  errorDisplay = false;
                  if(usd >= 0) {
                    // Store number of cups input in Homebrew instance
                    USDtoBTC usdConversion = USDtoBTC(usd);
                    //
                    _display = usdConversion.conversion();

                    //inputTextController.clear();
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