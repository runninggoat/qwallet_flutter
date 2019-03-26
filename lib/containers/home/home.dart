import 'package:flutter/material.dart';
import './wallet/wallet.dart';
import './market/market.dart';
import './settings/settings.dart';

class Home extends StatefulWidget {
  HomeState createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 1;

  List<Widget> _children = [
    Wallet(),
    Market(),
    Settings(),
  ];

  void onTabTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/images/wallet.png', width: 22, height: 22,),
            activeIcon: Image.asset('lib/assets/images/walletSelect.png', width: 24, height: 24,),
            title:Text('Wallet'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/images/market.png', width: 22, height: 22,),
            activeIcon: Image.asset('lib/assets/images/marketSelect.png', width: 24, height: 24,),
            title:Text('Market'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/images/settings.png', width: 22, height: 22,),
            activeIcon: Image.asset('lib/assets/images/settingsSelect.png', width: 24, height: 24,),
            title:Text('Settings'),
          ),
        ],
      ),
    );
  }
}
