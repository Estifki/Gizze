import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';
import '../../provider/auth/auth_user.dart';
import '../../provider/user/sand.dart';

class SandDetailsScreen extends StatefulWidget {
  final String sandID;
  final String sandName;
  final String sandDescription;
  final String sandImage;

  const SandDetailsScreen(
      {super.key,
      required this.sandID,
      required this.sandName,
      required this.sandDescription,
      required this.sandImage});
  @override
  State<SandDetailsScreen> createState() => _SandDetailsScreenState();
}

class _SandDetailsScreenState extends State<SandDetailsScreen> {
  bool isInit = true;
  late Future _sandData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _sandData = Provider.of<SandProvider>(context, listen: false)
          .getSandDetails(
              Provider.of<UserAuthProvider>(context).token!, widget.sandID);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.network(widget.sandImage),
              ),
              const SizedBox(height: 5),
              Text(
                widget.sandName,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              Text(
                widget.sandDescription,
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                "Sand Locations",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                  future: _sandData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade400,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              height: screenSize.height * 0.18,
                              width: screenSize.width,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      );
                      // return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Unknown Error"));
                    } else {
                      return Consumer<SandProvider>(
                        builder: (context, value, _) {
                          print(value.sandLocationData);
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.sandLocationData.length,
                            physics: const BouncingScrollPhysics(),
                            padding:
                                const EdgeInsets.only(left: 15.0, bottom: 10),
                            itemBuilder: (context, index) {
                              return Card(
                                margin:
                                    const EdgeInsets.only(top: 15.0, right: 15),
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Container(
                                  height: screenSize.height * 0.25,
                                  width: screenSize.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      //
                                      //Image
                                      //
                                      const SizedBox(width: 8),
                                      Image.network(
                                          value.sandLocationData[index].sand
                                              .sandImage,
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
                                                  value.sandLocationData[index]
                                                      .sand.name,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 3),
                                                //
                                                //Product Descrption
                                                //
                                                Text(
                                                  value.sandLocationData[index]
                                                      .sand.description,
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
                                                //     mainAxisAlignment:
                                                //         MainAxisAlignment.start,
                                                //     crossAxisAlignment:
                                                //         CrossAxisAlignment
                                                //             .start,
                                                //     children: [
                                                //       //
                                                //       //Address
                                                //       //
                                                //       AddressAndPriceWidget(
                                                //           title:
                                                //               "location name",
                                                //           //  value.featuredSand[index]
                                                //           //     .location.locationName,
                                                //           icon: Icons
                                                //               .location_on),
                                                //       //
                                                //       //Price
                                                //       //
                                                //       SizedBox(height: 2),
                                                //       AddressAndPriceWidget(
                                                //           title:
                                                //               "${value.sandLocationData[index].price} Birr/m²",
                                                //           // "${value.featuredSand[index].price} Birr/m²",
                                                //           icon: Icons
                                                //               .flip_to_back_rounded)
                                                //     ]),
                                                //
                                                //Order Now Button
                                                //
                                                const SizedBox(height: 10),
                                                GestureDetector(
                                                  // onTap: () {
                                                  //   Navigator.of(context)
                                                  //       .push(MaterialPageRoute(
                                                  //     builder:
                                                  //         (context) =>
                                                  //             SandDetailsScreen(
                                                  //                 sandID: value
                                                  //                     .featuredSand[index]
                                                  //                     .id,
                                                  //                 sandName: value
                                                  //                     .featuredSand[index]
                                                  //                     .name,
                                                  //                 sandDescription: value
                                                  //                     .featuredSand[index]
                                                  //                     .description,
                                                  //                 sandImage: value
                                                  //                     .featuredSand[index]
                                                  //                     .sandImage),
                                                  //   ));
                                                  // },
                                                  // onTap: () => showMoreSandInfo(
                                                  //     context: context,
                                                  //     sandName: value.featuredSand[index].name,
                                                  //     sandDescription:
                                                  //         value.featuredSand[index].description,
                                                  //     sandPrice: "free",
                                                  //     //value.featuredSand[index].price,
                                                  //     sandImageUrl:
                                                  //         value.featuredSand[index].sandImage),
                                                  child: Container(
                                                    width: screenSize.width,
                                                    height: screenSize.height *
                                                        0.046,
                                                    alignment: Alignment.center,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0)),
                                                    child: const Text(
                                                        "Order Now",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        // child:
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
