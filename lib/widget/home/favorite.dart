import 'package:ashewa_d/provider/user/sand.dart';
import 'package:ashewa_d/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';

class HomeFavoriteWidget extends StatelessWidget {
  const HomeFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          height: screenSize.height * 0.175,
          width: screenSize.width,
          child: Consumer<SandProvider>(
            builder: (context, value, _) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.favoriteSand.length,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 15.0),
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 2),
                        child: Card(
                            margin: const EdgeInsets.all(0.0),
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              width: screenSize.width * 0.38,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //
                                    //image
                                    //
                                    Center(
                                        child: Image.network(
                                            value.favoriteSand[index].sandImage,
                                            height: screenSize.height * 0.08)),
                                    //
                                    //Product Name
                                    //
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5),
                                      child: Text(
                                        value.favoriteSand[index].name,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Spacer(),
                                    //
                                    //Order Now Button
                                    //
                                    GestureDetector(
                                      onTap: () => showMoreSandInfo(
                                          context: context,
                                          sandName:
                                              value.favoriteSand[index].name,
                                          sandDescription: value
                                              .favoriteSand[index].description,
                                          sandPrice: "free",
                                          // value.favoriteSand[index].price,
                                          sandImageUrl: value
                                              .favoriteSand[index].sandImage),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  screenSize.height * 0.013),
                                          child: Container(
                                            height: screenSize.height * 0.032,
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            child: const Text("Order Now",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center),
                                          )),
                                    )
                                  ]),
                            )));
                  });
            },
            // child:
          )),
    );
  }
}
