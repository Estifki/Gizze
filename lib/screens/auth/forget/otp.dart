import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/../const/const.dart';
import '/../widget/otp.dart';
import 'new_password.dart';

class VerifyOtpForForgotScreen extends StatefulWidget {
  final String phone;
  const VerifyOtpForForgotScreen({required this.phone, super.key});
  @override
  State<VerifyOtpForForgotScreen> createState() =>
      _VerifyOtpForForgotScreenState();
}

class _VerifyOtpForForgotScreenState extends State<VerifyOtpForForgotScreen> {
  bool _isLoading = false;
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
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 22,
                color: Colors.black,
              )),
          title: const Text("Phone Verification",
              style: TextStyle(color: Colors.black)),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInputWidget(otpController: _otpController1),
                      OtpInputWidget(otpController: _otpController2),
                      OtpInputWidget(otpController: _otpController3),
                      OtpInputWidget(
                          otpController: _otpController4, isLast: true),
                    ]),
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
                            "Verify Phone Number",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          ),
                        ),
                      ),
              ]),
        ),
      ),
    );
  }

  void validate() async {
    String userInput =
        "${_otpController1.text}${_otpController2.text}${_otpController3.text}${_otpController4.text}";
    if (userInput.length < 4) {
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .verifyOtp(
                isForRegister: false, phone: widget.phone, code: userInput)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => NewPasswordScreen()),
              (route) => false);
        });
      } on CustomHttpException catch (e) {
        _otpController1.clear();
        _otpController2.clear();
        _otpController3.clear();
        _otpController4.clear();
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
      } catch (_) {
        _otpController1.clear();
        _otpController2.clear();
        _otpController3.clear();
        _otpController4.clear();
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later!");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
