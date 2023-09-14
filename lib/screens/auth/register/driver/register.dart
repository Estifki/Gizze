import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '/../../const/const.dart';
import '/../../widget/textfield.dart';
import '../../../../provider/auth.dart';
import '../../../../provider/location.dart';
import '../../../../provider/sand_location.dart';
import '../../../../uitil/http_error.dart';
import '../../../../uitil/toast.dart';
import '../../../driver/bottom_bar_driver.dart';

class RegisterScreenForDriver extends StatefulWidget {
  const RegisterScreenForDriver({super.key});

  @override
  State<RegisterScreenForDriver> createState() =>
      _RegisterScreenForDriverState();
}

class _RegisterScreenForDriverState extends State<RegisterScreenForDriver> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _accountnumberController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _colorController = TextEditingController();
  final _loadCapacityController = TextEditingController();
  final _sandLocationController = TextEditingController();
  final _cityController = TextEditingController();

  bool _isLoading = false;
  bool checkBoxValue = false;

  bool _isLocationPicked = false;
  PlatformFile? carOwnershipDocPath;
  PlatformFile? licenceDocPath;
  PlatformFile? profileImagePath;
  String carOwnershipDocName = "";
  String carOwnershipDocPathh = "";
  String licenceDocName = "";
  String licenceDocPathh = "";
  String profilePicName = "";
  String profilePicPathh = "";

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accountNameController.dispose();
    _accountnumberController.dispose();
    _bankNameController.dispose();
    _plateNumberController.dispose();
    _colorController.dispose();
    _loadCapacityController.dispose();
    _sandLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    Provider.of<SandLocationProvider>(context).getSandAddress();
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
          centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.04),
              //
              //Full Name
              //
              CustomTextFieldWidget(
                  hint: "Full Name", controller: _nameController),
              const SizedBox(height: 15),
              CustomTextFieldWidget(
                  hint: "Email", controller: _emailController),
              const SizedBox(height: 15),

              Container(
                height: 48,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.26),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 8),
                    child: Text("251",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: "",
                            fontWeight: FontWeight.w600,
                            color: AppColor.primaryColor)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      maxLength: 9,
                      onChanged: (val) {
                        if (!val.startsWith("9")) {
                          _phoneController.clear();
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText: "Phone"),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 15),
              CustomTextFieldWidget(hint: "City", controller: _cityController),

              // const SizedBox(height: 15),
              // //
              // //Phone Number Input
              // //
              // Container(
              //   height: 48,
              //   width: screenSize.width * 0.9,
              //   decoration: BoxDecoration(
              //       color: Colors.grey.withOpacity(0.26),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: Row(children: [
              //     const Padding(
              //       padding: EdgeInsets.only(left: 10.0, right: 8),
              //       child: Text("251",
              //           style: TextStyle(
              //               fontSize: 17,
              //               fontFamily: "",
              //               fontWeight: FontWeight.w600,
              //               color: AppColor.primaryColor)),
              //     ),
              //     Expanded(
              //       child: TextField(
              //         controller: _phoneController,
              //         maxLength: 9,
              //         onChanged: (val) {
              //           if (!val.startsWith("9")) {
              //             _phoneController.clear();
              //           }
              //         },
              //         keyboardType: TextInputType.phone,
              //         decoration: const InputDecoration(
              //             border: InputBorder.none,
              //             counterText: "",
              //             hintText: "Phone"),
              //       ),
              //     ),
              //   ]),
              // ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    setState(() {
                      profilePicName = file.name;
                      profilePicPathh = file.path!;
                      profileImagePath = file;
                    });
                  } else {
                    return;
                  }
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.26),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: profilePicName.isEmpty
                          ? Text(
                              "Upload Driver image",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )
                          : Text(
                              profilePicName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    setState(() {
                      carOwnershipDocName = file.name;
                      carOwnershipDocPathh = file.path!;
                      carOwnershipDocPath = file;
                    });
                  } else {
                    return;
                  }
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.26),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: carOwnershipDocName.isEmpty
                          ? Text(
                              "Car Ownership Document",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )
                          : Text(
                              carOwnershipDocName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    PlatformFile file = result.files.first;
                    setState(() {
                      licenceDocName = file.name;
                      licenceDocPathh = file.path!;
                      licenceDocPath = file;
                    });
                  } else {
                    return;
                  }
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.26),
                      borderRadius: BorderRadius.circular(6)),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: licenceDocName.isEmpty
                          ? Text(
                              "Licence Doc",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )
                          : Text(
                              licenceDocName,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade700),
                            )),
                ),
              ),

              const SizedBox(height: 15),
              //
              //Account Number
              //
              CustomTextFieldWidget(
                  hint: "Account Number", controller: _accountnumberController),
              const SizedBox(height: 15),
              //
              //Account Holder Name
              //
              CustomTextFieldWidget(
                  hint: "Account Holder Name",
                  controller: _accountNameController),
              const SizedBox(height: 15),
              //
              //Bank Name
              //
              CustomTextFieldWidget(
                  hint: "Bank Name", controller: _bankNameController),

              const SizedBox(height: 15),
              //
              //
              //
              CustomTextFieldWidget(
                  hint: "Plate Number", controller: _plateNumberController),
              const SizedBox(height: 15),
              //
              //
              //
              CustomTextFieldWidget(
                  hint: "Car Color", controller: _colorController),
              const SizedBox(height: 15),
              //
              //
              //
              CustomTextFieldWidget(
                  hint: "Load Capacity (M³)",
                  controller: _loadCapacityController),
              const SizedBox(height: 15),
              //
              //
              //
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: DropdownButtonFormField2(
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
                  icon:
                      const Icon(Icons.arrow_drop_down, color: Colors.black45),
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
                              style: const TextStyle(fontSize: 18),
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
                      _sandLocationController.text = value.toString();
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: screenSize.width * 0.05),
                child: GestureDetector(
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
                                "Updated Location",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                              )
                            : const Text(
                                "Pick Location",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.ellipsis),
                              ),
                      ]),
                ),
              ),
              const SizedBox(height: 15),
              //
              //Password
              //

              CustomTextFieldWidget(
                  hint: "Password", controller: _passwordController),
              const SizedBox(height: 15),
              //
              //Confirm Password
              //
              CustomTextFieldWidget(
                  hint: "Confirm Password",
                  controller: _confirmPasswordController),

              //
              //i Agree
              //
              Padding(
                padding:
                    EdgeInsets.only(left: screenSize.width * 0.03, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: checkBoxValue,
                          checkColor: Colors.white,
                          activeColor: AppColor.primaryColor,
                          onChanged: (_) {
                            setState(() {
                              checkBoxValue = !checkBoxValue;
                            });
                          }),
                      RichText(
                          text: const TextSpan(
                              text: "I agree to the ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "Term and Conditions",
                                style: TextStyle(color: AppColor.primaryColor))
                          ])),
                    ]),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Center(
                      child: Transform.scale(
                        scale: 0.6,
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : GestureDetector(
                      onTap: () => validate(),
                      child: Container(
                        height: 46,
                        width: screenSize.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: AppColor.primaryColor),
                        child: const Text(
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ),

              const SizedBox(height: 40),
            ]),
      ),
    );
  }

  void validate() async {
    if (_nameController.text.length < 2) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid Name");
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text)) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid email");
    } else if (_phoneController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Phone Number");
    } else if (_cityController.text.isEmpty) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid City");
    } else if (profilePicPathh == "") {
      showScaffoldMessanger(
          context: context, errorMessage: "Profile Image Not Selected");
    } else if (carOwnershipDocPathh == "") {
      showScaffoldMessanger(
          context: context,
          errorMessage: "Car Ownership Documnet Not Selected");
    } else if (licenceDocPathh == "") {
      showScaffoldMessanger(
          context: context, errorMessage: "licence Documnet Not Selected");
    } else if (_accountnumberController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Account Number");
    } else if (_accountNameController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Account Name");
    } else if (_bankNameController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Bank Name");
    } else if (_plateNumberController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Plate Number");
    } else if (_colorController.text.isEmpty) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid Color");
    } else if (_loadCapacityController.text.isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Load Capacity");
    } else if (_passwordController.text.length < 6) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password must be at least 6 digit.");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password do not match");
    } else if (checkBoxValue == false) {
      showScaffoldMessanger(
          context: context, errorMessage: "Term and Conditions Not Agreed");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .registerDriver(
          phone: "251${_phoneController.text}",
          accountNumber: _accountnumberController.text,
          accountholderName: _accountNameController.text,
          city: _cityController.text,
          bank: _bankNameController.text,
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          plateNumber: _plateNumberController.text,
          color: _colorController.text,
          capacity: _loadCapacityController.text.toString(),
          sandLocation: _sandLocationController.text.toString(),
          lat: Provider.of<LocationProvider>(context, listen: false)
              .userLat
              .toString(),
          long: Provider.of<LocationProvider>(context, listen: false)
              .userLong
              .toString(),
          carOwnershipDocPath: carOwnershipDocPath!,
          licenceDocPath: licenceDocPath!,
          profileImage: profileImagePath!,
        )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          showScaffoldMessanger(
              context: context,
              backgroundColor: Colors.green,
              errorMessage: "Driver Registered Successfully");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const DriverCustomBottomBar()),
              (route) => false);
        });
      } on CustomHttpException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      }
    }
  }
}
