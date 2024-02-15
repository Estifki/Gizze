// ignore_for_file: use_build_context_synchronously

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../uitil/http_error.dart';
import '../../../uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/location.dart';
import '../../../provider/sand_location.dart';
import '../../user/profile/profile_user.dart';

class AddSandScreen extends StatefulWidget {
  final String sandID;
  final String sandName;

  const AddSandScreen(
      {super.key, required this.sandID, required this.sandName});
  @override
  State<AddSandScreen> createState() => _AddSandScreenState();
}

class _AddSandScreenState extends State<AddSandScreen> {
  final _priceController = TextEditingController();
  String selectedSandAddress = "";

  bool _isLoading = false;
  bool _isLocationPicked = false;
  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.sandName,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SignInTextFieldWidget(
              hintText: "Sand Price",
              textInputType: TextInputType.number,
              controller: _priceController,
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_off, size: 0)),
            ),
            const SizedBox(height: 20),
            // DropdownButtonFormField2(
            //   isExpanded: true,
            //   decoration: InputDecoration(
            //     isDense: true,
            //     contentPadding: EdgeInsets.zero,
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(6.0),
            //     ),
            //   ),
            //   hint: const Text("Select Sand Address",
            //       style: TextStyle(fontSize: 17)),
            //   icon: const Icon(Icons.arrow_drop_down, color: Colors.black45),
            //   iconSize: 30,
            //   buttonHeight: 60,
            //   buttonPadding: const EdgeInsets.only(right: 10),
            //   dropdownDecoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   items: Provider.of<SandLocationProvider>(context)
            //       .sandAddressData
            //       .map((item) => DropdownMenuItem<String>(
            //             value: item.id,
            //             child: Text(
            //               item.name,
            //               style: const TextStyle(fontSize: 18),
            //             ),
            //           ))
            //       .toList(),
            //   validator: (value) {
            //     if (value == null) {
            //       return 'Sand Address Is Not Selected.';
            //     }
            //     return null;
            //   },
            //   onChanged: (value) {
            //     setState(() {
            //       selectedSandAddress = value.toString();
            //     });
            //   },
            // ),
            // const SizedBox(height: 20),
            GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actions: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                            height: 34,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLocationPicked = true;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            height: 34,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(6.0)),
                            child: const Text(
                              "Pick",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                    content: SizedBox(
                      height: 250,
                      child: GoogleMap(
                        // mapType: MapType.satellite,
                        myLocationButtonEnabled: true,
                        indoorViewEnabled: true,
                        // trafficEnabled: true,
                        // liteModeEnabled: true,
                        myLocationEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .userLat!,
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .userLong!),
                            zoom: 8),
                        markers: {
                          Marker(
                              markerId: const MarkerId("source"),
                              position: LatLng(
                                  Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .userLat!,
                                  Provider.of<LocationProvider>(context,
                                          listen: false)
                                      .userLong!)),
                        },
                      ),
                    ),
                  );
                },
              ),
              // onTap: () async {
              //   try {
              //     await showSimplePickerLocation(
              //       context: context,
              //       initZoom: 13,

              //       maxZoomLevel: 19.0,
              //       isDismissible: true,
              //       // title: "Pick Your address",
              //       textConfirmPicker: "Pick",
              //       textCancelPicker: "",
              //       initCurrentUserPosition: false,
              //       initPosition: GeoPoint(
              //           latitude: Provider.of<LocationProvider>(context,
              //                   listen: false)
              //               .userLat!,
              //           longitude: Provider.of<LocationProvider>(context,
              //                   listen: false)
              //               .userLong!),
              //     ).then((value) {
              //       lat = Provider.of<LocationProvider>(context, listen: false)
              //           .userLat!;
              //       long = Provider.of<LocationProvider>(context, listen: false)
              //           .userLong!;
              //       setState(() {
              //         locationPicked = true;
              //       });
              //     });
              //   } catch (e) {
              //     rethrow;
              //   }
              // },
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
                    _isLocationPicked
                        ? const Text(
                            "Updated Sand Location",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          )
                        : const Text(
                            "Pick Sand Location",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          ),
                  ]),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : GestureDetector(
                    onTap: () => validate(),
                    child: Container(
                      height: 46,
                      width: screenSize.width,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: const Text("Add Sand",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  validate() async {
    if (_priceController.text.isEmpty) {
      showScaffoldMessanger(context: context, errorMessage: "Price is Invalid");
    }
    //  else if (selectedSandAddress == "") {
    //   showScaffoldMessanger(
    //       context: context, errorMessage: "Price address is Invalid");
    // }
    else if (_isLocationPicked == false) {
      showScaffoldMessanger(
          context: context, errorMessage: "Please Pick Sand Location");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<SandLocationProvider>(context, listen: false)
            .addSandLocation(
                token: Provider.of<AuthProvider>(context, listen: false).token!,
                sandID: widget.sandID,
                price: _priceController.text,
                // locationID: selectedSandAddress,
                lat: Provider.of<LocationProvider>(context, listen: false)
                    .userLat!,
                long: Provider.of<LocationProvider>(context, listen: false)
                    .userLong!)
            .then((_) {
          showScaffoldMessanger(
              backgroundColor: Colors.green,
              context: context,
              errorMessage: "Sand Added Success");
          Navigator.of(context).pop();
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
