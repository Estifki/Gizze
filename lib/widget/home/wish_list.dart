import '../../provider/sand.dart';
import '../../screens/user/sand_details.dart';
import '../bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/const.dart';

class HomeWishListWidget extends StatelessWidget {
  const HomeWishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          height: screenSize.height * 0.17,
          width: screenSize.width,
          child: Consumer<SandProvider>(
            builder: (context, value, _) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.wishListData.length,
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
                              width: screenSize.width * 0.4,
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
                                            value.wishListData[index].sand
                                                .sandImage,
                                            height: screenSize.height * 0.074)),
                                    //
                                    //Product Name
                                    //
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        value.wishListData[index].sand.name,
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
                                      onTap: () {
                                        Provider.of<SandProvider>(context,
                                                listen: false)
                                            .cleanSandDetails();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              SandDetailsScreen(
                                                  isFromWishList:  value
                                                      .wishListData[index].id,
                                                  sandID: value
                                                      .wishListData[index]
                                                      .sandId,
                                                  sandName: value
                                                      .wishListData[index]
                                                      .sand
                                                      .name,
                                                  sandDescription: value
                                                      .wishListData[index]
                                                      .sand
                                                      .description,
                                                  sandImage: value
                                                      .wishListData[index]
                                                      .sand
                                                      .sandImage),
                                        ));
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  screenSize.height * 0.015),
                                          child: Container(
                                            height: 30,
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(6.0)),
                                            child: const Text("See More",
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