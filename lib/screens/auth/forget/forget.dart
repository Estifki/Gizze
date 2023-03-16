import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import 'otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Forgot Password"),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
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
                            "Recover Password",
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
    if (_phoneController.text.length != 9) {
      showScaffoldMessanger(
          context: context, errorMessage: "Invalid Phone Number");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .resetPassword("251${_phoneController.text}")
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerifyOtpForForgotScreen(
                    phone: "251${_phoneController.text}",
                  )));
        });
      } on CustomHttpException catch (e) {
        showScaffoldMessanger(context: context, errorMessage: e.toString());
        setState(() {
          _isLoading = false;
        });
      } catch (_) {
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
