import 'package:ashewa_d/const/const.dart';
import 'package:flutter/material.dart';

import '../widget/home/appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: const [
          //
          //Custom App Bar
          //
          CustomHomeAppBarWidget()
          //
          //Favourite
          //
        ]),
      )),
    );
  }
}
