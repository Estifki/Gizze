import 'package:ashewa_d/provider/user/sand.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';
import '../../provider/auth/auth_user.dart';
import '../../screens/user/sand_details.dart';
import '../bottom_sheet.dart';
import 'adderss_price.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<SandProvider>(
      builder: (context, value, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.featuredSand.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15.0, bottom: 10),
          itemBuilder: (context, index) {
            return Card(
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
                    Image.network(value.featuredSand[index].sandImage,
                        width: screenSize.width * 0.43),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                value.featuredSand[index].description,
                                maxLines: 2,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
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
                                  Provider.of<SandProvider>(context,
                                          listen: false)
                                      .cleanSandDetails();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SandDetailsScreen(
                                        sandID: value.featuredSand[index].id,
                                        sandName:
                                            value.featuredSand[index].name,
                                        sandDescription: value
                                            .featuredSand[index].description,
                                        sandImage: value
                                            .featuredSand[index].sandImage),
                                  ));
                                },
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
                                  height: screenSize.height * 0.046,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(right: 5.0),
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius: BorderRadius.circular(6.0)),
                                  child: const Text("Order Now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.white),
                                      textAlign: TextAlign.center),
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
}
