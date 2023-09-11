import '../../../provider/auth.dart';
import '../../../provider/orders.dart';
import '../../../uitil/http_error.dart';
import '../../../uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../provider/location.dart';
import '../../driver/profile.dart';
import '../bottom_bar.dart';

class OrderSandScreen extends StatefulWidget {
  final String orderID;
  final String sandName;
  final String sandImage;
  final String address;
  final String pricePerCubic;
  final double lat;
  final double long;
  // final double destinationLat;
  // final double destinationLong;

  // final String deliveryManName;

  // final String deliveryManPhone;

  const OrderSandScreen(
      {super.key,
      required this.orderID,
      required this.sandName,
      required this.sandImage,
      required this.address,
      required this.pricePerCubic,
      required this.lat,
      required this.long
      // required this.totalPrice,
      // required this.sourceLat,
      // required this.sourceLong,
      // required this.destinationLat,
      // required this.destinationLong,
      // required this.deliveryManName,
      // required this.deliveryManPhone,
      });

  @override
  State<OrderSandScreen> createState() => _OrderSandScreenState();
}

class _OrderSandScreenState extends State<OrderSandScreen> {
  final _amountController = TextEditingController();
  final _deliveryLocationNameController = TextEditingController();
  bool locationPicked = false;
  double? lat;
  double? long;
  String totalPrice = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.sandName, style: const TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(widget.sandImage,
                      width: screenSize.width * 0.4),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pric:  Br ${widget.pricePerCubic}",
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 4),
                      Text("Address:  ${widget.address}",
                          style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 4),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text("Sand Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 15),
              Container(
                height: screenSize.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GoogleMap(
                    // mapType: MapType.satellite,
                    myLocationButtonEnabled: true,
                    indoorViewEnabled: true,
                    // trafficEnabled: true,
                    // liteModeEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.lat, widget.long), zoom: 8),
                    markers: {
                      Marker(
                          markerId: const MarkerId("source"),
                          position: LatLng(widget.lat, widget.long)),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Delivery Info",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              // const SizedBox(height: 15),
              // SignInTextFieldWidget(
              //   hintText: "amount",
              //   textInputType: TextInputType.number,
              //   controller: _amountController,
              //   suffixIcon: IconButton(
              //       onPressed: () {},
              //       icon: const Icon(Icons.visibility_off, size: 0)),
              // ),
              const SizedBox(height: 10),
              SignInTextFieldWidget(
                hintText: "Delivery Location Name",
                textInputType: TextInputType.text,
                controller: _deliveryLocationNameController,
                suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_off, size: 0)),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  try {
                    await showSimplePickerLocation(
                      context: context,
                      initZoom: 13,

                      maxZoomLevel: 19.0,
                      isDismissible: true,
                      // title: "Pick Your address",
                      textConfirmPicker: "Pick",
                      textCancelPicker: "",
                      initCurrentUserPosition: false,
                      initPosition: GeoPoint(
                          latitude: Provider.of<LocationProvider>(context,
                                  listen: false)
                              .userLat!,
                          longitude: Provider.of<LocationProvider>(context,
                                  listen: false)
                              .userLong!),
                    ).then((value) {
                      lat = value!.latitude;
                      long = value.longitude;
                      setState(() {
                        locationPicked = true;
                      });
                    });
                  } catch (e) {
                    rethrow;
                  }
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(Icons.location_pin,
                            size: 22, color: AppColor.primaryColor),
                      ),
                      const SizedBox(width: 13),
                      locationPicked
                          ? const Text(
                              "Update Delivery Location",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                            )
                          : const Text(
                              "Pick Delivery Location",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                            ),
                    ]),
              ),
              const SizedBox(height: 15),
              _isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : GestureDetector(
                      onTap: () => validate(),
                      child: Container(
                        height: 46,
                        width: screenSize.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Text(
                          "Order Now",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  validate() async {
    // if (_amountController.text.isEmpty) {
    //   showScaffoldMessanger(
    //       context: context, errorMessage: "Please Add Amount");
    // } else
    if (_deliveryLocationNameController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Please Add Delivery Location");
    } else if (lat == null || long == null) {
      showScaffoldMessanger(
          context: context, errorMessage: "Please Pick Sand Delivery Location");
    } else {
      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<OrderProvider>(context, listen: false)
            .orderSand(
                token: Provider.of<AuthProvider>(context, listen: false).token!,
                sandID: widget.orderID,
                price: (5 * int.parse(widget.pricePerCubic)).toString(),
                // amount: _amountController.text,
                locationName: _deliveryLocationNameController.text,
                lat: lat!.toDouble(),
                long: long!.toDouble())
            .then((_) {
          showScaffoldMessanger(
              context: context,
              errorMessage: "Sand Ordered Success",
              backgroundColor: Colors.green);
          Provider.of<UserCustomBottomBarProvider>(context, listen: false)
              .resetIndex();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const UserCustomBottomBar()),
              (route) => false);
          setState(() {
            _isLoading = false;
          });
        });
      } on CustomHttpException catch (e) {
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
