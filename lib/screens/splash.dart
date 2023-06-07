import 'dart:async';
import 'package:ashewa_d/screens/home.dart';
import 'package:ashewa_d/screens/onboarding.dart';
import 'package:ashewa_d/uitil/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//
import '../provider/auth/auth_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration.zero, () {
      Provider.of<UserAuthProvider>(context, listen: false).getUserAndToken();
    });
    Timer(const Duration(seconds: 2), () {
      if (Provider.of<UserAuthProvider>(context, listen: false).userID == null) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const OnBoardingScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const CustomBottomBar()),
        );
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
