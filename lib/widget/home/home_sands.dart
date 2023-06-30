import 'package:ashewa_d/provider/sand.dart';
import 'package:ashewa_d/widget/home/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        children: [
          //
          // Custom App Bar
          //
          const CustomHomeAppBarWidget(),
          //
          //wish List
          //
          Provider.of<SandProvider>(context).wishListData.isNotEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20),
                  child: Text(
                    "Wish List",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(),
          Provider.of<SandProvider>(context).wishListData.isNotEmpty
              ? const HomeWishListWidget()
              : Container(),
          //
          // Favourite
          //
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 20),
            child: Text(
              "Most Viewed",
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
            padding: EdgeInsets.only(left: 16.0, top: 20),
            child: Text(
              "Recently Added",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const FeaturedProductWidget(),
        ],
      ),
    );
  }
}
