import 'package:flutter/material.dart';

import '../../const/const.dart';

class HomeFavoriteWidget extends StatelessWidget {
  const HomeFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          height: screenSize.height * 0.155,
          width: screenSize.width,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20.0),
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 2),
                    child: Card(
                        margin: const EdgeInsets.all(0.0),
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          width: screenSize.width * 0.36,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                //image
                                //
                                Center(
                                    child: Image.asset(data[index].imageUrl,
                                        height: screenSize.height * 0.08)),
                                //
                                //Product Name
                                //
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    data[index].name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Spacer(),
                                //
                                //Order Now Button
                                //
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: screenSize.height * 0.009),
                                    child: Center(
                                        child: Container(
                                      width: screenSize.width * 0.31,
                                      height: screenSize.height * 0.032,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Text("Order Now",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center),
                                    )))
                              ]),
                        )));
              })),
    );
  }
}
