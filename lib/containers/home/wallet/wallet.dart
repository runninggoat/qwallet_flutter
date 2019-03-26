import 'package:flutter/material.dart';
import '../../widgets/Jumbotron.dart';
import '../../widgets/TokenList.dart';

class Wallet extends StatelessWidget {
  Widget build(BuildContext context) {
    String address = '0xabcdefghijklmnopq';
    List<Map> tokens = [
      {
        'name': 'ETH',
        'amount': 10,
      },
      {
        'name': 'IPChain',
        'amount': 100,
      },
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Jumbotron(address),
        Expanded(child: TokenList(tokens), flex: 1,),
      ],
    );
  }
}
