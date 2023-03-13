import 'package:ashewa_d/screens/auth/login.dart';
import 'package:flutter/material.dart';

import '../../../const/const.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool checkBoxValue = false;

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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.04),
              //
              //Full Name
              //
              Container(
                height: 48,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.26),
                    borderRadius: BorderRadius.circular(6)),
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Full Name",
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),

              const SizedBox(height: 15),
              //
              //Email
              //
              Container(
                height: 48,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.26),
                    borderRadius: BorderRadius.circular(6)),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Email",
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
              const SizedBox(height: 15),
              //
              //Password
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
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
              const SizedBox(height: 15),
              //
              //Confirm Password
              //
              Container(
                height: 48,
                width: screenSize.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.26),
                    borderRadius: BorderRadius.circular(6)),
                child: TextField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                      hintText: "Confirm Password",
                      contentPadding: EdgeInsets.only(left: 10)),
                ),
              ),
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
                              style: TextStyle(fontSize: 16),
                              children: [
                            TextSpan(
                                text: "Term and Conditions",
                                style: TextStyle(color: AppColor.primaryColor))
                          ])),
                    ]),
              ),
              const SizedBox(height: 20),
              Container(
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
    );
  }
}
