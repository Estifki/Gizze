import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/const.dart';
import '../../provider/auth/auth_user.dart';
import '../../provider/location.dart';
import '../../provider/user/sand.dart';
import '../driver/profile.dart';
import 'order/add_order.dart';

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
              Provider.of<AuthProvider>(context).token!, widget.sandID);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.sandName),
      ),
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
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade400,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: screenSize.height * 0.15,
                                  width: screenSize.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text("Unknown Error"));
                    } else {
                      return const SandDetailsLocationsWidget();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class SandDetailsLocationsWidget extends StatelessWidget {
  const SandDetailsLocationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<SandProvider>(
      builder: (context, value, _) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: value.sandLocationData[0].sandLocations.length,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15.0, bottom: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderSandScreen(
                    orderID: value.sandLocationData[0].sandLocations[index].id,
                    sandName: value.sandLocationData[0].name,
                    sandImage: value.sandLocationData[0].sandImage,
                    address: value
                        .sandLocationData[0].sandLocations[index].location.name,
                    pricePerCubic:
                        value.sandLocationData[0].sandLocations[index].price,
                    lat: value.sandLocationData[0].sandLocations[index]
                        .destinationLocation.latitude,
                    long: value.sandLocationData[0].sandLocations[index]
                        .destinationLocation.longitude),
              )),
              child: Card(
                margin: const EdgeInsets.only(top: 15.0, right: 15),
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: screenSize.height * 0.19,
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
                          value.sandLocationData[0].sandLocations[index].sand
                              .sandImage,
                          width: screenSize.width * 0.4),
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
                                  value.sandLocationData[0].sandLocations[index]
                                      .location.name,
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
                                  value.sandLocationData[0].sandLocations[index]
                                      .sand.description,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Br ${value.sandLocationData[0].sandLocations[index].price}",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black),
                                ),

                                const SizedBox(height: 6),

                                //
                                //Order Now Button
                                //
                                const SizedBox(height: 10),
                                GestureDetector(
                                  child: Container(
                                    width: screenSize.width,
                                    height: screenSize.height * 0.046,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 5.0),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(6.0)),
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
              ),
            );
          },
        );
      },
      // child:
    );
  }
}
