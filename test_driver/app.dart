import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/config/globals.dart' as globals;

// Initialize the MockClient class
class MockClient extends Mock implements http.Client{}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Generate instance of mock client and the JSON response that will be expected
  final client = MockClient();
  final fakeAPIData = '{"time": {"updated": "Nov 5, 2020 19:01:00 UTC", "updatedISO": "2020-11-05T219:01:00+00:00", "updateduk": "Nov 5, 2020 at 19:01 GMT"}, "disclaimer": "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openxchangerates.org", "bpi": { "USD": {"code": "USD", "rate": "14,934.5833", "description": "United States Dollar", "rate_float": 42000.0000}}}'; 
  var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');

  // Makes it so whenever this instance of client requests a response from the above URL the response will be as initialized
  when(client.get(url)).thenAnswer((_) async => http.Response(fakeAPIData, 200));

  // Make the mock client global, accessible accross files
  globals.httpClient = client;

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
