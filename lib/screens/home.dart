import 'package:flutter/material.dart';

import '../widget/home/appbar.dart';
import '../widget/home/favorite.dart';
import '../widget/home/featured.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffedf2f6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              //
              // Custom App Bar
              //
              CustomHomeAppBarWidget(),
              //
              // Favourite
              //
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  "Favorites",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              HomeFavoriteWidget(),
              //
              // Featured Properties
              //

              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Text(
                  "Featured Products",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              FeaturedProductWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
