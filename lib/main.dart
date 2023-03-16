import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/screens/auth/forget/new_password.dart';
import 'package:ashewa_d/screens/home.dart';
import 'package:ashewa_d/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gizze',
          theme: ThemeData.dark().copyWith(
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.black)),
          home: OnBoardingScreen(),
          routes: {
            AppRoute.home: (_) => const HomeScreen(),
            AppRoute.newPassword: (_) => const NewPasswordScreen(),
          }),
    );
  }
}
