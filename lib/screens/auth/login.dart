import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/screens/auth/register/user/phone.dart';
import 'package:ashewa_d/screens/driver/bottom_bar_driver.dart';
import 'package:ashewa_d/screens/user/home.dart';

import 'package:ashewa_d/uitil/http_error.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../widget/textfield.dart';
import '../user/bottom_bar.dart';
import 'forget/forget.dart';

class SignInScreenForUser extends StatefulWidget {
  const SignInScreenForUser({super.key});

  @override
  State<SignInScreenForUser> createState() => _SignInScreenForUserState();
}

class _SignInScreenForUserState extends State<SignInScreenForUser> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
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
        //   onTap: () => Navigator.of(context).pop(),
        //   child: const Icon(Icons.arrow_back_ios_new, size: 22),
        // ),
        title: const Text("Sign In", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
              height: screenSize.height - 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * 0.04),
                  //
                  //Phone Number Input
                  //
                  Container(
                    height: 48,
                    width: screenSize.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.26),
                        borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      children: [
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  //
                  //Password Input
                  //

                  CustomTextFieldWidget(
                      hint: "Password",
                      controller: _passwordController,
                      leftcontentPadding: 50,
                      isObsquired: true),
                  //
                  //Sign In Button
                  //

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
                              "Sign In",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 19, color: Colors.white),
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),
                  //
                  //Forget Password
                  //
                  GestureDetector(
                    // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const ForgotPasswordScreen())),
                    child: const Text(
                      "Forgot Password",
                      style:
                          TextStyle(fontSize: 16, color: AppColor.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: screenSize.height * 0.0,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (context) =>
                    //         const PhoneRegisterScreenForUser()));
                  },
                  child: const Text(
                    "Create An Account",
                    style:
                        TextStyle(fontSize: 16, color: AppColor.primaryColor),
                  ),
                ))
          ]),
        ),
      )),
    );
  }

  void validate() async {
    if (_phoneController.text.length != 9) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Phone Number");
    } else if (_passwordController.text.length < 6) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password To Short");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        FocusScope.of(context).unfocus();
        await Provider.of<AuthProvider>(context, listen: false)
            .signIn("251${_phoneController.text}", _passwordController.text)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          if (Provider.of<AuthProvider>(context, listen: false).role ==
              "Driver") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const DriverCustomBottomBar()),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const UserCustomBottomBar()),
                (route) => false);
          }
        });
      } on CustomHttpException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (e) {
        print(e.toString());
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(
            context: context, errorMessage: "Try Again Later");
      }
    }
  }
}
