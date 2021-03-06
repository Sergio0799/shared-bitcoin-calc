// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

  group('Home Screen', () {
    final USDtoBTCBtnFinder = find.byValueKey('USDtoBTC-button');
    final BTCtoUSDBtnFinder = find.byValueKey('BTCtoUSD-button');

    test('should go to USD-to-BTC screen when press button', () async {
      await driver.tap(USDtoBTCBtnFinder);

      final findConvertButtonText = find.byValueKey('USD-convert-text');

      expect(await driver.getText(findConvertButtonText), "Convert");

      final USDBackBtnFinder = find.byValueKey('USD-back-button');
      await driver.tap(USDBackBtnFinder);
    });

    test('should go to BTC-to-USD screen when press button', () async {
      await driver.tap(BTCtoUSDBtnFinder);

      final findConvertButtonText = find.byValueKey('BTC-convert-text');

      expect(await driver.getText(findConvertButtonText), "Convert");
      
       
      final BTCBackBtnFinder = find.byValueKey('BTC-back-button');
      await driver.tap(BTCBackBtnFinder);
    });
    
  });
  
  group('USD-to-BTC screen', () {
    final USDtoBTCBtnFinder = find.byValueKey('USDtoBTC-button');

    test('should convert input USD value to BTC', () async {
      await driver.tap(USDtoBTCBtnFinder);

      final findUSDTextField = find.byValueKey('USD-textfield');
      final convertBtnFinder = find.byValueKey('USD-convert-button');
      
      await driver.tap(findUSDTextField);
      await driver.enterText('42000.0');
      await driver.waitFor(find.text('42000.0'));
      
      await driver.tap(convertBtnFinder);

      final findOutputText = find.byValueKey('USDtoBTC-output');
      
      expect(await driver.getText(findOutputText), '1.0');
    });
    
    test('should display error if user input is negative' , () async {
      final findUSDTextField = find.byValueKey('USD-textfield');
      final convertBtnFinder = find.byValueKey('USD-convert-button');
      
      await driver.tap(findUSDTextField);
      await driver.enterText('-5.0');
      await driver.waitFor(find.text('-5.0'));
      
      await driver.tap(convertBtnFinder);
      
      await driver.waitFor(find.text("Invalid - Negative Number"));
    });

    test('should display error if user input is not a number' , () async {
      final findUSDTextField = find.byValueKey('USD-textfield');
      final convertBtnFinder = find.byValueKey('USD-convert-button');
      
      await driver.tap(findUSDTextField);
      await driver.enterText(',');
      await driver.waitFor(find.text(','));
      
      await driver.tap(convertBtnFinder);
      
      await driver.waitFor(find.text("Invalid Input"));
    });

    test('should be able to return to Home screen with back button', () async {
      final USDBackBtnFinder = find.byValueKey('USD-back-button');
      
      await driver.tap(USDBackBtnFinder);

      final findUSDtoBTCText = find.byValueKey('USDtoBTC-text');

      expect(await driver.getText(findUSDtoBTCText), "USD to BTC");
    });

  });

  group ('BTC-to-USD screen' , () {
    final BTCtoUSDBtnFinder = find.byValueKey('BTCtoUSD-button');

    test('testing a single BTC to USD conversion',() async{
      await driver.tap(BTCtoUSDBtnFinder);

      final findBTCTextField = find.byValueKey('BTC-textfield');
      final convertBtnFinder = find.byValueKey('BTC-convert-button');
      
      await driver.tap(findBTCTextField);
      await driver.enterText('1');
      await driver.waitFor(find.text('1'));

      await driver.tap(convertBtnFinder);

      final findOutputText = find.byValueKey('BTCtoUSD-output');
      
      expect(await driver.getText(findOutputText), '42000.0');


    });
    test('should display error if user input is negative' , () async {
      final findBTCTextField = find.byValueKey('BTC-textfield');
      final convertBtnFinder = find.byValueKey('BTC-convert-button');
      
      await driver.tap(findBTCTextField);
      await driver.enterText('-5.0');
      await driver.waitFor(find.text('-5.0'));
      
      await driver.tap(convertBtnFinder);

      final findOutputText = find.byValueKey('BTCtoUSD-output');
      
      await driver.waitFor(find.text("Invalid - Negative Number"));
      
    });
    
    test('should display error if user input is not a number' , () async {
      final findBTCTextField = find.byValueKey('BTC-textfield');
      final convertBtnFinder = find.byValueKey('BTC-convert-button');
      
      await driver.tap(findBTCTextField);
      await driver.enterText(',');
      await driver.waitFor(find.text(','));
      
      await driver.tap(convertBtnFinder);
      
      await driver.waitFor(find.text("Invalid Input"));
      
    });

  test('return to home screen with current screen back button', () async{
    final BTCtoUSDBtnFinder = find.byValueKey('BTC-back-button');

    await driver.tap(BTCtoUSDBtnFinder);

    final findBTCtoUSDText = find.byValueKey('BTCtoUSD-text');

    expect(await driver.getText(findBTCtoUSDText), "BTC to USD");

  });
  });
}
