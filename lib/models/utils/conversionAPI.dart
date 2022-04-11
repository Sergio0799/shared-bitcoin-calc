import 'package:http/http.dart' as http;
import 'dart:convert';

// Class used to retrieve the current exchange rate of Bitcoin/USD using Coindesk API
class BitcoinAPI{
  static Future<double> fetchConversion(http.Client client) async {
    var url = Uri.parse('https://api.coindesk.com/v1/bpi/currentprice/usd.json');
    // Store JSON response when querying the Coindesk API client (link above)
    final response = await client.get(url);

    // Check if HTTP response successful(200) and return the conversion rate value, otherwise throw Exception
    if(response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    }
    else{
      throw Exception('Failed to load conversion rate');
    }
  }

  ////---Function used to display current conversion rate as text on main screen---////
  // static Future<String> fetchDisplay(http.Client client) async{
  //   var url = Uri.parse(
  //     'https://api.coindesk.com/v1/bpi/currentprice/usd.json');
  //   final response = await client.get(url);

  //   if(response.statusCode == 200)
  //   {
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     return json["bpi"]["USD"]["rate_float"].toString();
  //   }
  //   else
  //   {
  //     throw Exception('Failed to load conversion rate');
  //   }
  // }
}