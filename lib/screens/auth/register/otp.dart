import 'package:ashewa_d/screens/auth/register/register.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../uitil/http_error.dart';
import '../../../widget/otp.dart';

class VerifyOtpForRegisterScreen extends StatefulWidget {
  final String phone;
  const VerifyOtpForRegisterScreen({required this.phone});
  @override
  State<VerifyOtpForRegisterScreen> createState() =>
      _VerifyOtpForRegisterScreenState();
}

class _VerifyOtpForRegisterScreenState
    extends State<VerifyOtpForRegisterScreen> {
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
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .verifyOtp(
                isForRegister: true, phone: widget.phone, code: userInput)
            .then((_) {
          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoute.registerScreen, (route) => false);
        });
      } on CustomHttpException catch (e) {
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
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
