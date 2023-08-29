import 'dart:async';

import 'package:ashewa_d/screens/user/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
import '../provider/auth.dart';
import '../provider/location.dart';
import 'driver/bottom_bar_driver.dart';
import 'onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration.zero, () {
      Provider.of<AuthProvider>(context, listen: false).getUserAndToken();
    });
    Timer(const Duration(seconds: 2), () {
      
    Provider.of<LocationProvider>(context, listen: false).getUserAddress();
      if (Provider.of<AuthProvider>(context, listen: false).userID ==
          null) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const OnBoardingScreen()),
        );
      } else {
        if (Provider.of<AuthProvider>(context, listen: false).role ==
            "Driver") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const DriverCustomBottomBar()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>  CategoryScreen()),
              (route) => false);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Artboard 2-1.png"),
                  fit: BoxFit.contain),
            ),
          ),
        ),
      ]),
    );
  }
}
