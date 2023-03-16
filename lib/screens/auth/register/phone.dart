import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/screens/auth/register/otp.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../login.dart';

class PhoneRegisterScreen extends StatefulWidget {
  const PhoneRegisterScreen({super.key});

  @override
  State<PhoneRegisterScreen> createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Sign Up"),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
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
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: const Text(
                "Already Have an Account",
                style: TextStyle(fontSize: 16, color: AppColor.primaryColor),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void validate() async {
    if (_phoneController.text.length != 9) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid Phone");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .phoneRegister(phone: "251${_phoneController.text}")
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyOtpForRegisterScreen(
                  phone: "251${_phoneController.text}")));
        });
      } on CustomHttpException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (_) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later");
      }
    }
  }
}
