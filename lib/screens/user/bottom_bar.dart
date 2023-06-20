import 'dart:io';

import 'package:ashewa_d/screens/user/order/my_orders.dart';
import 'package:ashewa_d/screens/user/home.dart';
import 'package:ashewa_d/screens/user/profile_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserCustomBottomBar extends StatefulWidget {
  const UserCustomBottomBar({super.key});

  @override
  State<UserCustomBottomBar> createState() => _UserCustomBottomBarState();
}

class _UserCustomBottomBarState extends State<UserCustomBottomBar> {
  List<Widget> _screen = [
    HomeScreenForUser(),
    MyOrdersScreen(),
    ProfileScreenForUser()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen.elementAt(
            Provider.of<UserCustomBottomBarProvider>(context).selectedIndex),
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
              currentIndex: Provider.of<UserCustomBottomBarProvider>(context)
                  .selectedIndex,
              onTap: (index) {
                Provider.of<UserCustomBottomBarProvider>(context, listen: false)
                    .onIndexChange(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.money_off_csred_sharp),
                    label: "My Orders"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ));
  }
}

class UserCustomBottomBarProvider with ChangeNotifier {
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
