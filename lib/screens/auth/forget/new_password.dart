import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/widget/textfield.dart';
import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new, size: 22),
        ),
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenSize.height * 0.04),
              //
              //Phone Number Input
              //
              CustomTextFieldWidget(
                  hint: "New Password", controller: _passwordController),
              const SizedBox(height: 15),
              //
              //Password Input
              //

              CustomTextFieldWidget(
                hint: "Confirm Password",
                controller: _confirmPasswordController,
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
                  "Reset Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              //
              //Forget Password
              //
            ],
          ),
        ),
      )),
    );
  }
}
