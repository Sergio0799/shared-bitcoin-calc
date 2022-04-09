import 'package:test/test.dart';

// Import exchange tools file
import 'package:bitcoin_calculator/models/exchange_tools.dart';

void main() {
  group("USD to BTC conversion", () {
    test("constructor should set amount of US Dollars based on user input", ()  {
      // Variable represents the amount of US Dollars input
      var USD = 45605.40;

      // Initialize an instance of USDtoBTC class using the amount of USD input
      final instance = USDtoBTC(USD);

      // Expect amount given to constructor is stored in instance
      expect(instance.amountUSD(), 45605.40);
    });
    

    test("testing conversion function", () {
      // Variable represents the amount of US Dollars input
      var conversion = 45605.40;

      // Initialize an instance of USDtoBTC class using the amount of USD input
      final instance = USDtoBTC(conversion);

      // Expect amount given to constructor is stored in instance
      expect(instance.conversion(45605.40), 1.0);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => USDtoBTC(-1), throwsArgumentError);
    });
    
  });

  group("BTC to USD conversion", () {
    test("constructor should set amount of BTC based on user input", ()  {
      // Variable represents the amount of US Dollars input
      var BTC = 1.0;

      // Initialize an instance of USDtoBTC class using the amount of USD input
      final instance = BTCtoUSD(BTC);

      // Expect amount given to constructor is stored in instance
      expect(instance.amountBTC(),1.0 );
    });

    
    test('throws ArgumentError on negative number', () {
      expect(() => BTCtoUSD(-1), throwsArgumentError);
    });
    

    test("testing conversion function", () {
      // Variable represents the amount of US Dollars input
      var conversion = 1.0;

      // Initialize an instance of USDtoBTC class using the amount of USD input
      final instance = BTCtoUSD(conversion);

      // Expect amount given to constructor is stored in instance
      expect(instance.conversion(45605.40),  45605.40);
    });
    
  });

}
