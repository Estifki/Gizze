import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/orders.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../../../provider/location.dart';
import '../../user/profile_user.dart';

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
  bool locationPicked = false;

  double? lat;
  double? long;

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          widget.sandName,
          style: const TextStyle(fontSize: 16),
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
            DropdownButtonFormField2(
              isExpanded: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              hint: const Text("Select Sand Address",
                  style: TextStyle(fontSize: 17)),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black45),
              iconSize: 30,
              buttonHeight: 60,
              buttonPadding: const EdgeInsets.only(right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: Provider.of<OrderProvider>(context)
                  .sandAddressData
                  .map((item) => DropdownMenuItem<String>(
                        value: item.id,
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Sand Address Is Not Selected.';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  selectedSandAddress = value.toString();
                });
              },
            ),
            const SizedBox(height: 20),
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
                            "Update Sand Location",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          )
                        : const Text(
                            "Pick Sand Location",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}