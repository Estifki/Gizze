import '../../provider/sand.dart';
import 'wish_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';
import '../../screens/user/sand_details.dart';
import 'appbar.dart';
import 'favorite.dart';
import 'featured.dart';

class HomeSandsWidget extends StatefulWidget {
  const HomeSandsWidget({super.key});

  @override
  State<HomeSandsWidget> createState() => _HomeSandsWidgetState();
}

class _HomeSandsWidgetState extends State<HomeSandsWidget> {
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // Custom App Bar
          //
          Container(
            height: 170,
            width: screenSize.width,
            color: Colors.black,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const CircleAvatar(
                          //   radius: 20,
                          //   backgroundColor: AppColor.primaryColor,
                          // ),
                          const Icon(Icons.more_vert,
                              size: 30, color: Colors.black),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset("assets/Artboard 3-1.png",
                                fit: BoxFit.cover, color: Colors.white),
                          ),

                          const Icon(Icons.logout, size: 0, color: Colors.white)
                        ]),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      height: 46,
                      width: screenSize.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.26),
                          borderRadius: BorderRadius.circular(6.0)),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Colors.grey.withOpacity(0.7),
                        cursorWidth: 1.0,
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(left: 10),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.withOpacity(0.7),
                            )),
                      ),
                    ),
                  )
                ]),
          ),
          //
          //wish List
          //
          searchQuery.isEmpty
              ? Provider.of<SandProvider>(context).wishListData.isNotEmpty
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
                  : Container()
              : Container(),
          searchQuery.isEmpty
              ? Provider.of<SandProvider>(context).wishListData.isNotEmpty
                  ? const HomeWishListWidget()
                  : Container()
              : Container(),
          //
          // Favourite
          //
          searchQuery.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20),
                  child: Text(
                    "Most Viewed",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(),
          searchQuery.isEmpty ? const HomeFavoriteWidget() : Container(),
          //
          // Featured Properties
          //

          searchQuery.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20),
                  child: Text(
                    "Recently Added",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 20),
                  child: Text(
                    "Search Result",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

          Consumer<SandProvider>(builder: (context, value, _) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: value.featuredSand.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                itemBuilder: (context, index) {
                  return value.featuredSand[index].name
                          .toLowerCase()
                          .contains(searchQuery)
                      ? Card(
                          margin: const EdgeInsets.only(top: 15.0, right: 15),
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Container(
                            height: screenSize.height * 0.18,
                            width: screenSize.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //
                                  //Image
                                  //
                                  const SizedBox(width: 8),
                                  Image.network(
                                      value.featuredSand[index].sandImage,
                                      width: screenSize.width * 0.43),
                                  const SizedBox(width: 10),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //
                                            //Product Name
                                            //
                                            Text(
                                              value.featuredSand[index].name,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 3),
                                            //
                                            //Product Descrption
                                            //
                                            Text(
                                              value.featuredSand[index]
                                                  .description,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black),
                                            ),

                                            const SizedBox(height: 6),
                                            //
                                            //address and price
                                            //
                                            // Column(
                                            //     mainAxisAlignment: MainAxisAlignment.start,
                                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                            //     children: const [
                                            //       //
                                            //       //Address
                                            //       //
                                            //       AddressAndPriceWidget(
                                            //           title: "location name",
                                            //           //  value.featuredSand[index]
                                            //           //     .location.locationName,
                                            //           icon: Icons.location_on),
                                            //       //
                                            //       //Price
                                            //       //
                                            //       SizedBox(height: 2),
                                            //       AddressAndPriceWidget(
                                            //           title: "Price",
                                            //           // "${value.featuredSand[index].price} Birr/m²",
                                            //           icon: Icons.flip_to_back_rounded)
                                            //     ]),
                                            //
                                            //Order Now Button
                                            //
                                            const SizedBox(height: 10),
                                            GestureDetector(
                                              onTap: () {
                                                Provider.of<SandProvider>(
                                                        context,
                                                        listen: false)
                                                    .cleanSandDetails();
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      SandDetailsScreen(
                                                          sandID: value
                                                              .featuredSand[
                                                                  index]
                                                              .id,
                                                          sandName:
                                                              value
                                                                  .featuredSand[
                                                                      index]
                                                                  .name,
                                                          sandDescription: value
                                                              .featuredSand[
                                                                  index]
                                                              .description,
                                                          sandImage: value
                                                              .featuredSand[
                                                                  index]
                                                              .sandImage),
                                                ));
                                              },
                                              child: Container(
                                                width: screenSize.width,
                                                height: 34,
                                                alignment: Alignment.center,
                                                margin: const EdgeInsets.only(
                                                    right: 5.0),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColor.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0)),
                                                child: const Text("See More",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            )
                                          ]),
                                    ),
                                  )
                                ]),
                          ),
                        )
                      : index == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Text(
                                "No sand found \n $searchQuery ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            )
                          : Container();
                });
          })
        ],
      ),
    );
  }
}
