import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../uitil/http_error.dart';
import '../../../uitil/toast.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../../../provider/location.dart';
import '../../../provider/sand_location.dart';
import '../../user/profile/profile_user.dart';

class UpdateMySandScreen extends StatefulWidget {
  final String sandID;
  final String sandName;
  final String sandPrice;

  const UpdateMySandScreen(
      {super.key,
      required this.sandID,
      required this.sandName,
      required this.sandPrice});
  @override
  State<UpdateMySandScreen> createState() => _UpdateMySandScreenState();
}

class _UpdateMySandScreenState extends State<UpdateMySandScreen> {
  final _priceController = TextEditingController();
  String selectedSandAddress = "";
  bool locationPicked = false;
  bool _isUpdateLoading = false;

  bool _isDeleteLoading = false;

  @override
  void initState() {
    _priceController.text = widget.sandPrice;
    super.initState();
  }

  double? lat;
  double? long;

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
              items: Provider.of<SandLocationProvider>(context)
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
            const SizedBox(height: 20),
            _isUpdateLoading
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
                      child: const Text("Update Sand",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  ),
            const SizedBox(height: 20),
            _isDeleteLoading
                ? const Center(child: CircularProgressIndicator.adaptive())
                : GestureDetector(
                    onTap: () => deleteSand(),
                    child: Container(
                      height: 46,
                      width: screenSize.width,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6.0)),
                      child: const Text("Delete Sand",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                          textAlign: TextAlign.center),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  deleteSand() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isDeleteLoading = true;
    });
    try {
      Provider.of<SandLocationProvider>(context, listen: false)
          .deleteSandLocation(
              token:
                  Provider.of<AuthProvider>(context, listen: false).token!,
              sandID: widget.sandID)
          .then((value) {
        showScaffoldMessanger(
            backgroundColor: Colors.green,
            context: context,
            errorMessage: "Sand Deleted Success");
        Navigator.of(context).pop();
        setState(() {
          _isDeleteLoading = false;
        });
      });
    } on CustomHttpException catch (e) {
      showScaffoldMessanger(context: context, errorMessage: e.toString());
      setState(() {
        _isDeleteLoading = false;
      });
    } catch (e) {
      showScaffoldMessanger(
          context: context, errorMessage: "Please Try Again Later!");
      setState(() {
        _isDeleteLoading = false;
      });
    }
  }

  validate() async {
    if (_priceController.text.isEmpty) {
      showScaffoldMessanger(context: context, errorMessage: "Price is Invalid");
    } else if (selectedSandAddress == "") {
      showScaffoldMessanger(
          context: context, errorMessage: "Sand address is Invalid");
    } else if (lat == null) {
      showScaffoldMessanger(
          context: context, errorMessage: "Please Pick Sand Location");
    } else {
      FocusScope.of(context).unfocus();
      setState(() {
        _isUpdateLoading = true;
      });
      try {
        Provider.of<SandLocationProvider>(context, listen: false)
            .updateSandLocation(
                token: Provider.of<AuthProvider>(context, listen: false)
                    .token!,
                sandID: widget.sandID,
                price: _priceController.text,
                locationID: selectedSandAddress,
                lat: lat!.toDouble(),
                long: long!.toDouble())
            .then((value) {
          showScaffoldMessanger(
              backgroundColor: Colors.green,
              context: context,
              errorMessage: "Sand Updated Success");
          Navigator.of(context).pop();
          setState(() {
            _isUpdateLoading = false;
          });
        });
      } on CustomHttpException catch (e) {
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isUpdateLoading = false;
        });
      } catch (e) {
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later!");
        setState(() {
          _isUpdateLoading = false;
        });
      }
    }
  }
}
