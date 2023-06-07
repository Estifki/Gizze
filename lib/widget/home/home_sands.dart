import 'package:flutter/material.dart';

import 'appbar.dart';
import 'favorite.dart';
import 'featured.dart';


class HomeSandsWidget extends StatelessWidget {
  const HomeSandsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}