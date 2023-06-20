import 'dart:io';

import 'package:ashewa_d/screens/driver/sands.dart';
import 'package:ashewa_d/screens/order/my_orders.dart';
import 'package:ashewa_d/screens/user/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile.dart';

class DriverCustomBottomBar extends StatefulWidget {
  const DriverCustomBottomBar({super.key});

  @override
  State<DriverCustomBottomBar> createState() => _DriverCustomBottomBarState();
}

class _DriverCustomBottomBarState extends State<DriverCustomBottomBar> {
  List<Widget> _screen = [
    MyOrdersScreen(),
    SandscreenForDriver(),
    ProfileScreenForDriver()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen.elementAt(
          Provider.of<DriverCustomBottomBarProvider>(context).selectedIndex,
        ),
        bottomNavigationBar: SizedBox(
          height: Platform.isIOS ? null : 56,
          child: BottomNavigationBar(
              // backgroundColor: AppColor.lightBackground,
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              // fixedColor: AppColor.primaryColor,
              // iconSize: 24,
              unselectedLabelStyle: const TextStyle(fontSize: 11.0),
              selectedLabelStyle: const TextStyle(fontSize: 13.0),
              currentIndex: Provider.of<DriverCustomBottomBarProvider>(context)
                  .selectedIndex,
              onTap: (index) {
                Provider.of<DriverCustomBottomBarProvider>(context,
                        listen: false)
                    .onIndexChange(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Order"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dataset), label: "Sands"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ));
  }
}

class DriverCustomBottomBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onIndexChange(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void resetIndex() {
    _selectedIndex = 0;
  }
}
