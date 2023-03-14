import 'package:flutter/material.dart';

import '../../const/const.dart';
import 'adderss_price.dart';

class FeaturedProductWidget extends StatelessWidget {
  const FeaturedProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
      itemBuilder: (context, index) {
        List<ProductM> dataa = data.reversed.toList();
        return Card(
          margin: const EdgeInsets.only(top: 15.0, right: 10),
          shadowColor: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            height: screenSize.height * 0.23,
            width: screenSize.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                //Image
                //
                const SizedBox(width: 8),
                Image.asset(dataa[index].imageUrl,
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
                            dataa[index].name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          //
                          //Product Descrption
                          //
                          Text(
                            dataa[index].description,
                            maxLines: 2,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black),
                          ),

                          const SizedBox(height: 10),
                          //
                          //address and price
                          //
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  //Address
                                  //
                                 AddressAndPriceWidget(
                                      title: dataa[index].address,
                                      icon: Icons.location_on),
                                  //
                                  //Price
                                  //
                                  AddressAndPriceWidget(
                                      title: "${dataa[index].price} Birr/m²",
                                      icon: Icons.flip_to_back_rounded)
                                ]),
                          ),
                          //
                          //Order Now Button
                          //
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              width: screenSize.width,
                              height: screenSize.height * 0.046,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(6.0)),
                              child: const Text("Order Now",
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
  }
}
