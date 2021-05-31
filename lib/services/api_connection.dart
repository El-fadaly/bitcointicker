import 'dart:convert';

import 'package:http/http.dart' as http;

import '../coin_data.dart';

class ApiConnection {
  Future<Map<String, double>> getCurrencyData(String real) async {
    var response = await http.get(
      Uri.parse(
          'https://apiv2.bitcoinaverage.com/indices/global/ticker/all?crypto=BTC,ETH,LTC&fiat=$real'),
      headers: <String, String>{
        'x-ba-key': 'YzBmMDczMWU1MGE0NDdkYzhkMzA4YTcyNDcyZjBiOGE',
      },
    );

    print(response);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      // print('BTC');
      // print(decodedData['BTC$real']['last']);
      // print('ETH');
      // print(decodedData['ETH$real']['last']);
      // print('LTC');
      // print(decodedData['LTC$real']['last']);

      Map<String, double> currencyData = Map();
      for (String crypto in cryptoList) {
        currencyData['$crypto'] = decodedData['$crypto$real']['last'];
      }

      return currencyData;
    } else {
      print(response.statusCode);
    }
  }
}
