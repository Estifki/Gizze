import 'package:flutter/material.dart';

import '../const/const.dart';
import '../screens/auth/login.dart';
import '../screens/auth/register/driver/register.dart';
import '../screens/auth/register/user/phone.dart';

class ContinueAsWidget extends StatelessWidget {
  final bool isLogin;
  final bool isRegister;

  const ContinueAsWidget(
      {super.key, required this.isLogin, required this.isRegister});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          height: 170,
          width: screenSize.width * 0.65,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Continue As",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  if (isLogin) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  } else if (isRegister) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            const PhoneRegisterScreenForUser()));
                  }
                },
                child: Container(
                  height: 36,
                  width: 140,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppColor.primaryColor,
                  ),
                  child: const Text(
                    "User",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (isLogin) {
                    // print("Login for Driver");
                  } else if (isRegister) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const RegisterScreenForDriver()));
                  }
                },
                child: Container(
                  height: 36,
                  width: 140,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppColor.primaryColor,
                  ),
                  child: const Text(
                    "Driver",
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
