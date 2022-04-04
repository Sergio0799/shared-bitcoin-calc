import 'package:flutter/material.dart';

import 'package:bitcoin_calculator/models/exchange_tools.dart';
import 'package:bitcoin_calculator/main.dart';

class InputUSDScreen extends StatefulWidget {
  USDtoBTC instance;
  InputUSDScreen(this.instance);

  @override
  _InputUSDScreen createState() => _InputUSDScreen();
}

class _InputUSDScreen extends State<InputUSDScreen> {
  bool _input = false;

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
            key: Key('cups-back-button')
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

        )
      )
    );
  }
}