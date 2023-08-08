import 'dart:io';

import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../uitil/http_error.dart';
import '../../driver/profile.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool obscureText = true;
  bool _isLoading = false;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    _oldController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Update Password", style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.05),
                SignInTextFieldWidget(
                  hintText: "Old Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  controller: _oldController,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: obscureText
                        ? const Icon(Icons.visibility_off, size: 0)
                        : const Icon(Icons.visibility, size: 0),
                  ),
                ),

                const SizedBox(height: 15),
                SignInTextFieldWidget(
                  hintText: "New Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: obscureText
                        ? const Icon(Icons.visibility_off, size: 0)
                        : const Icon(Icons.visibility, size: 0),
                  ),
                ),

                const SizedBox(height: 15),
                //
                //Confirm Password
                //
                SignInTextFieldWidget(
                  hintText: "Confirm Password",
                  textInputType: TextInputType.visiblePassword,
                  obscureText: obscureText,
                  controller: _confirmController,
                  suffixIcon: IconButton(
                    onPressed: () => showPassword(),
                    icon: obscureText
                        ? const Icon(Icons.visibility_off, size: 20)
                        : const Icon(Icons.visibility, size: 20),
                  ),
                ),

                const SizedBox(height: 32),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: GestureDetector(
                          onTap: () => validateUpdate(context),
                          child: Container(
                            alignment: Alignment.center,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "Update Password",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
              ]),
        ),
      ),
    );
  }

  validateUpdate(BuildContext context) async {
    if (_oldController.text.trim().isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Old password is required");
    } else if (_oldController.text.trim().length <= 5) {
      showScaffoldMessanger(
          context: context,
          errorMessage: "Old Password must be at least 6 digit");
    } else if (_passwordController.text.trim().length <= 5) {
      showScaffoldMessanger(
          context: context,
          errorMessage: "New Password must be at least 6 digit");
    } else if (_passwordController.text.trim() !=
        _confirmController.text.trim()) {
      showScaffoldMessanger(
          context: context, errorMessage: "New Password do not match");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .updatePassword(
                oldPassword: _oldController.text.trim(),
                newPassword: _confirmController.text.trim())
            .then((_) {
          showScaffoldMessanger(
              backgroundColor: Colors.green,
              context: context,
              errorMessage: "Password Updated Successfully");
          setState(() {
            _isLoading = false;
          });
          Future.delayed(const Duration(microseconds: 500), () {
            Navigator.of(context).pop();
          });
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
