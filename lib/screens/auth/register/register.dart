import 'package:flutter/material.dart';

import '../../../const/const.dart';
import '../../../widget/textfield.dart';

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
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: const Icon(Icons.arrow_back_ios_new, size: 22)),
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
              CustomTextFieldWidget(
                  hint: "Full Name", controller: _nameController),

              const SizedBox(height: 15),
              //
              //Email
              //
              CustomTextFieldWidget(
                  hint: "Email", controller: _emailController),
              const SizedBox(height: 15),
              //
              //Password
              //

              CustomTextFieldWidget(
                  hint: "Password", controller: _passwordController),
              const SizedBox(height: 15),
              //
              //Confirm Password
              //
              CustomTextFieldWidget(
                  hint: "Confirm Password",
                  controller: _confirmPasswordController),

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
            ]),
      ),
    );
  }
}
