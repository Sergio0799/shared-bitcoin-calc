class USDtoBTC {
  double _btcRate = 45605.40;
  double _numUSD;

  // Constructor is initialized with amount of USD input
  USDtoBTC(double amount) {
    _numUSD = amount;
  }

  // Output stored value for US Dollars
  double amountUSD() {
    return _numUSD;
  }

  // Conversion function returns amount of Bitcoin
  double conversion() {
    return _numUSD / _btcRate;
  }
}

class BTCtoUSD {
  double _btcRate = 45605.40;
  double _numBTC;

  // Constructor is initialized with amount of BTC input
  BTCtoUSD(double amount) {
    _numBTC = amount;
  }

  // Conversion function returns amount of US Dollars
  double conversion() {
    return _numBTC * _btcRate;
  }
  double amountBTC() {
    return _numBTC;
  }

}