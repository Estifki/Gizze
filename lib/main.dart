import 'dart:io';

import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/provider/sand.dart';
import 'package:ashewa_d/screens/auth/forget/new_password.dart';
import 'package:ashewa_d/screens/auth/register/user/register.dart';
import 'package:ashewa_d/screens/home.dart';
import 'package:ashewa_d/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => SandProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gizze',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0.0)),
      // theme: ThemeData.dark().copyWith(
      //     primaryColor: Colors.black,
      //     scaffoldBackgroundColor: Colors.black,
      //     appBarTheme: const AppBarTheme(backgroundColor: Colors.black)),
      home: RegisterScreenForUser(),
      // routes: {
      //   AppRoute.home: (_) => const HomeScreen(),
      //   AppRoute.newPassword: (_) => const NewPasswordScreen(),
      //   AppRoute.registerScreen: (_) => const RegisterScreenForUser()
      // }
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
