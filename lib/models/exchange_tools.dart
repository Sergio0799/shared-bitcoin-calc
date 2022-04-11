class USDtoBTC {
   double _numUSD;

  // Constructor is initialized with amount of USD input
  USDtoBTC(double amount) {
    if (amount >= 0) {
      _numUSD = amount;
    }
    // Throw error if USD amount is negative
    else {
      throw ArgumentError();
    }
  }

  // Output stored value for US Dollars
  double amountUSD() {
    return _numUSD;
  }

  // Conversion function returns amount of Bitcoin
  double conversion(double rate) {
    return _numUSD / rate;
  }
}

class BTCtoUSD {
  double _numBTC;

  // Constructor is initialized with amount of BTC input
  BTCtoUSD(double amount) {
    if (amount >= 0) {
      _numBTC = amount;
    }
    // Throw error if BTC amount is negative
    else {
      throw ArgumentError();
    }
  }

  // Output stored value for bitcoin
  double amountBTC() {
    return _numBTC;
  }

  // Conversion function returns amount of US Dollars
  double conversion(double rate) {
    return _numBTC * rate;
  }
}