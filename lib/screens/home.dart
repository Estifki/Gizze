import 'package:flutter/material.dart';

import '../const/const.dart';
import '../widget/home/appbar.dart';
import '../widget/home/favorite.dart';

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
      backgroundColor: const Color(0xffedf2f6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // Custom App Bar
            //
            const CustomHomeAppBarWidget(),
            //
            // Favourite
            //
            const Padding(
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
            const HomeFavoriteWidget(),
            //
            // Featured Properties
            //

            const Padding(
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

            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 8.0, top: 15),
              itemBuilder: (context, index) {
                return Container(
                  height: screenSize.height * 0.2,
                  width: screenSize.width,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   backgroundColor: const Color(0xffedf2f6),
    //   body: SafeArea(
    //       child: ListView(
    //           // mainAxisAlignment: MainAxisAlignment.start,
    //           // crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //         //
    //         //Custom App Bar
    //         //
    //         const CustomHomeAppBarWidget(),
    //         //
    //         //Favourite
    //         //
    //         const Padding(
    //           padding: EdgeInsets.only(left: 20.0, top: 20),
    //           child: Text("Favorites",
    //               style: TextStyle(
    //                   fontSize: 19,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.black)),
    //         ),
    //         const HomeFavoriteWidget(),
    //         //
    //         //Featured Properties
    //         //
    //         const Padding(
    //           padding: EdgeInsets.only(left: 20.0, top: 20),
    //           child: Text("Featured Products",
    //               style: TextStyle(
    //                   fontSize: 19,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.black)),
    //         ),
    //         ListView.builder(
    //           shrinkWrap: true,
    //           itemCount: data.length,
    //           physics: const BouncingScrollPhysics(),
    //           // scrollDirection: Axis.horizontal,
    //           padding: const EdgeInsets.only(left: 8.0, top: 10),
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.only(left: 12, bottom: 5),
    //               child: Card(
    //                 margin: const EdgeInsets.all(0.0),
    //                 shadowColor: Colors.grey,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10.0),
    //                 ),
    //                 child: Container(
    //                   width: screenSize.width * 0.36,
    //                   decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(10.0)),
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Center(
    //                           child: Image.asset(data[index].imageUrl,
    //                               height: screenSize.height * 0.08)),
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 8.0),
    //                         child: Text(
    //                           data[index].name,
    //                           style: const TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.bold),
    //                         ),
    //                       ),
    //                       const Spacer(),
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             bottom: screenSize.height * 0.0075),
    //                         child: Center(
    //                           child: Container(
    //                             width: screenSize.width * 0.31,
    //                             height: screenSize.height * 0.032,
    //                             alignment: Alignment.center,
    //                             decoration: BoxDecoration(
    //                                 color: AppColor.primaryColor,
    //                                 borderRadius: BorderRadius.circular(10.0)),
    //                             child: const Text("Order Now",
    //                                 style:
    //                                     TextStyle(fontWeight: FontWeight.bold),
    //                                 textAlign: TextAlign.center),
    //                           ),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         )
    //       ])),
    // );
  }
}
