import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../provider/auth/auth_driver.dart';
import '../../../../uitil/http_error.dart';
import '../../../../uitil/toast.dart';
import '../../login.dart';
import '/../../const/const.dart';
import '/../../widget/textfield.dart';
import 'package:file_picker/file_picker.dart';

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

  // final _phoneController = TextEditingController();

  final _cityController = TextEditingController();
  bool _isLoading = false;
  bool checkBoxValue = false;
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
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
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

              CustomTextFieldWidget(
                  hint: "Phone Number", controller: _phoneController),
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
                                  fontSize: 16, color: Colors.grey.shade700),
                            )
                          : Text(
                              profilePicName,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade700),
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
                                  fontSize: 16, color: Colors.grey.shade700),
                            )
                          : Text(
                              carOwnershipDocName,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade700),
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
                                  fontSize: 16, color: Colors.grey.shade700),
                            )
                          : Text(
                              licenceDocName,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade700),
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
                                  TextStyle(fontSize: 16, color: Colors.black),
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
        await Provider.of<DriverAuthProvider>(context, listen: false)
            .resgisterDriver(
          phone: "251${_phoneController.text}",
          accountNumber: _accountnumberController.text,
          accountholderName: _accountNameController.text,
          city: _cityController.text,
          carOwnershipDocPath: carOwnershipDocPath!,
          bank: _bankNameController.text,
          licenceDocPath: licenceDocPath!,
          profileImage: profileImagePath!,
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          showScaffoldMessanger(
              context: context,
              backgroundColor: Colors.green,
              errorMessage: "User Registered Successfully");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SignInScreenForUser(),
              ),
              (route) => false);
        });
      } on CustomHttpException catch (e) {
        print("A ${e.toString()}");
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (e) {
        print("B ${e.toString()}");
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later");
      }
    }
  }
}
