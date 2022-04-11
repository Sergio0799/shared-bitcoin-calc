import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/models/utils/conversionAPI.dart';


class MockClient extends Mock implements http.Client{}

main (){
  group("API-handling-tests", () {
    test("Testing successful status code 200", () async {
      final client = MockClient();
      final FakeAPIData = '{"time": {"updated": "Nov 5, 2020 19:01:00 UTC", "updatedISO: "2020-11-05T219:01:00+00:00", "updateduk: "Nov 5, 2020 at 19:01 GMT" }, "displaimer:"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openxchangerates.org", "bpi: {"USD": { "code": "USD", "rate": "14,934.5833","description: "United States Dollar", "rate_float": 14934}}'; 
      var url = Uri.parse(
      'https://api.coindesk.com/v1/bpi/currentprice/usd.json');

      when(client.get(url)).thenAnswer((_) async => http.Response(FakeAPIData,200));

      double rate = await BitcoinAPI.fetchConversion(client);
      
      expect(rate, isA<double>());

      expect(rate,14934 );
    });

    test("Testing unsuccessful status code of 404", () async {
      final client = MockClient();
      //final FakeAPIData = '{"time": {"updated": "Nov 5, 2020 19:01:00 UTC", "updatedISO: "2020-11-05T219:01:00+00:00", "updateduk: "Nov 5, 2020 at 19:01 GMT" }, "displaimer:"This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openxchangerates.org", "bpi: {"USD": { "code": "USD", "rate": "14,934.5833","description: "United States Dollar", "rate_float": 14934}}'; 
      var url = Uri.parse(
      'https://api.coindesk.com/v1/bpi/currentprice/usd.json');

      when(client.get(url)).thenAnswer((_) async => http.Response('Not Found',404));
      
      
      expect(BitcoinAPI.fetchConversion(client), throwsException);
    });
  });    
}