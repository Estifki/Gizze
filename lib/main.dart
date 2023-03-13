import 'package:ashewa_d/screens/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ashewa Delivery',
        theme: ThemeData.dark().copyWith(
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black)),
        home: OnBoardingScreen());
  }
}
