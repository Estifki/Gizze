import 'package:ashewa_d/const/const.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
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

                  Container(
                    height: 48,
                    width: screenSize.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.26),
                        borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText: "Password",
                          contentPadding: EdgeInsets.only(left: 48)),
                    ),
                  ),
                  //
                  //Sign In Button
                  //

                  const SizedBox(height: 20),
                  Container(
                    height: 46,
                    width: screenSize.width * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppColor.primaryColor),
                    child: const Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //
                  //Forget Password
                  //
                  const Text(
                    "Forgot Password",
                    style:
                        TextStyle(fontSize: 18, color: AppColor.primaryColor),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: screenSize.height * 0.0,
                child: const Text(
                  "Create An Account",
                  style: TextStyle(fontSize: 18, color: AppColor.primaryColor),
                ))
          ]),
        ),
      )),
    );
  }
}
