import 'package:bitcoin_ticker/services/api_connection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValueCurrency = currenciesList.first;
  var currencyMapData;
  @override
  @mustCallSuper
  void initState() {
    getCurrenciesData();
  }

  void getCurrenciesData() async {
    EasyLoading.show();
    ApiConnection apiConnection = ApiConnection();
    var currencyData =
        await apiConnection.getCurrencyData(selectedValueCurrency);
    EasyLoading.dismiss();

    setState(() {
      currencyMapData = currencyData;
      print(currencyMapData);
      // // currencyMapData = currencyData['BTC'];
      // ethData = currencyData['ETH'];
      // ltcData = currencyData['LTC'];
      // print(btcData);
      // print(ethData);
      // print(ltcData);
    });
  }

  DropdownButton androidPicker() {
    List<DropdownMenuItem<String>> menuItems = [];

    for (String currency in currenciesList) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    print(menuItems);
    return DropdownButton(
      value: selectedValueCurrency,
      items: menuItems,
      onChanged: (selectedItem) {
        setState(() {
          selectedValueCurrency = selectedItem;
          getCurrenciesData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }
    print(pickerItems);
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectIndex) {
        selectedValueCurrency = currenciesList[selectIndex];
      },
      children: pickerItems,
    );
  }

  Widget getCards() {
    List<SpecialCardWidget> cardList = <SpecialCardWidget>[];
    for (String crypto in cryptoList) {
      cardList.add(SpecialCardWidget(
        crypto: crypto,
        cryptoRate:
            currencyMapData == null ? '?' : currencyMapData[crypto].toString(),
        selectedValueCurrency: selectedValueCurrency,
      ));
    }
    print(cardList);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cardList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // child: iosPicker(),
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

class SpecialCardWidget extends StatelessWidget {
  SpecialCardWidget({this.crypto, this.cryptoRate, this.selectedValueCurrency});

  final String crypto;
  final String selectedValueCurrency;
  final String cryptoRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $cryptoRate $selectedValueCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
// SpecialCardWidget(
//     crypto: btcData, selectedValueCurrency: selectedValueCurrency),
// Padding(
//   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//   child: Card(
//     color: Colors.lightBlueAccent,
//     elevation: 5.0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//     child: Padding(
//       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//       child: Text(
//         '1 ETH = $ethData $selectedValueCurrency',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 20.0,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   ),
// ),
// Padding(
//   padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
//   child: Card(
//     color: Colors.lightBlueAccent,
//     elevation: 5.0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//     child: Padding(
//       padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
//       child: Text(
//         '1 LTC = $ltcData $selectedValueCurrency',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 20.0,
//           color: Colors.white,
//         ),
//       ),
//     ),
//   ),
// ),
