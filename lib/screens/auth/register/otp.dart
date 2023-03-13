import 'package:ashewa_d/screens/auth/register/register.dart';
import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../widget/otp.dart';

class VerifyOtpForRegisterScreen extends StatefulWidget {
  const VerifyOtpForRegisterScreen({super.key});

  @override
  State<VerifyOtpForRegisterScreen> createState() =>
      _VerifyOtpForRegisterScreenState();
}

class _VerifyOtpForRegisterScreenState
    extends State<VerifyOtpForRegisterScreen> {
  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  @override
  void dispose() {
    super.dispose();

    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Phone Verification"),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.04),
              const Text(
                "Get Your Code",
                style: TextStyle(fontSize: 25),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20.0, top: 10),
                child: Text(
                  "Lorem Lorem Lorem Lore Lorem",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                OtpInputWidget(otpController: _otpController1),
                OtpInputWidget(otpController: _otpController2),
                OtpInputWidget(otpController: _otpController3),
                OtpInputWidget(otpController: _otpController4, isLast: true),
              ]),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
                },
                child: Container(
                  height: 46,
                  width: screenSize.width * 0.9,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: AppColor.primaryColor),
                  child: const Text(
                    "Verify Phone Number",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
