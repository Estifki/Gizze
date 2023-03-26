import 'package:ashewa_d/provider/sand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../uitil/shimmer/home.dart';
import '../widget/home/appbar.dart';
import '../widget/home/favorite.dart';
import '../widget/home/featured.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInit = true;
  late Future _sandData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _sandData = Provider.of<SandProvider>(context, listen: false).getSand();
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffedf2f6),
      body: SafeArea(
        child: FutureBuilder(
          future: _sandData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const HomeShimmer();
              // return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Unknown Error"));
            } else {
              // return HomeShimmer();
              return SingleChildScrollView(
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
                      padding: EdgeInsets.only(left: 16.0, top: 20),
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
                      padding: EdgeInsets.only(left: 16.0, top: 20),
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
              );
            }
          },
          // child:
        ),
      ),
    );
  }
}
