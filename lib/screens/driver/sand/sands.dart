import 'package:ashewa_d/provider/user/sand.dart';
import 'package:ashewa_d/screens/driver/sand/add_sand.dart';
import 'package:ashewa_d/widget/home/adderss_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../provider/auth/auth_user.dart';
import '../../../uitil/shimmer/home.dart';
import '../../../widget/home/appbar.dart';
import '../../../widget/home/favorite.dart';
import '../../../widget/home/featured.dart';
import '../../../widget/home/home_sands.dart';

class SandscreenForDriver extends StatefulWidget {
  const SandscreenForDriver({super.key});

  @override
  State<SandscreenForDriver> createState() => _SandscreenForDriverState();
}

class _SandscreenForDriverState extends State<SandscreenForDriver> {
  bool isInit = true;
  late Future _sandData;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _sandData = Provider.of<SandProvider>(context, listen: false)
          .getSand(Provider.of<UserAuthProvider>(context).token!);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedf2f6),
      body: SafeArea(
        child: Provider.of<SandProvider>(context).favoriteSand.isNotEmpty
            ? const DriverSandsWidget()
            : FutureBuilder(
                future: _sandData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const HomeShimmer();
                    // return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Unknown Error"));
                  } else {
                    // return HomeShimmer();
                    return const DriverSandsWidget();
                  }
                }),
      ),
    );
  }
}

class DriverSandsWidget extends StatelessWidget {
  const DriverSandsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<SandProvider>(
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

                                //
                                //Add Sand Button
                                //
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => AddSandScreen(
                                              sandID:
                                                  value.featuredSand[index].id,
                                              sandName: value
                                                  .featuredSand[index].name))),
                                  child: Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.044,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 5.0),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
                                    child: const Text("Add Sand",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
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
      ),
    );
  }
}
