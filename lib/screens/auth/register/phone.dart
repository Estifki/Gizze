import 'package:flutter/material.dart';

import '../../../const/const.dart';
import 'otp.dart';

class PhoneRegisterScreen extends StatefulWidget {
  const PhoneRegisterScreen({super.key});

  @override
  State<PhoneRegisterScreen> createState() => _PhoneRegisterScreenState();
}

class _PhoneRegisterScreenState extends State<PhoneRegisterScreen> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Sign Up"),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const VerifyOtpForRegisterScreen()));
                },
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
            ],
          ),
        ),
      ),
    );
  }
}
