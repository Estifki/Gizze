import 'package:ashewa_d/uitil/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../const/const.dart';
import '../../../../provider/auth.dart';
import '../../../../uitil/http_error.dart';
import '../../../../widget/textfield.dart';

class RegisterScreenForUser extends StatefulWidget {
  const RegisterScreenForUser({super.key});

  @override
  State<RegisterScreenForUser> createState() => _RegisterScreenForUserState();
}

class _RegisterScreenForUserState extends State<RegisterScreenForUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool checkBoxValue = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // leading: GestureDetector(
          //     onTap: () => Navigator.of(context).pop(),
          //     child: const Icon(Icons.arrow_back_ios_new, size: 22)),
          title: const Text("Sign Up", style: TextStyle(color: Colors.black)),
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
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              children: [
                            TextSpan(
                                text: "Term and Conditions",
                                style: TextStyle(color: AppColor.primaryColor))
                          ])),
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
                          "Sign Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ),
            ]),
      ),
    );
  }

  void validate() async {
    if (_nameController.text.length < 2) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid Name");
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text)) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid email");
    } else if (_passwordController.text.length < 6) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password must be at least 6 digit.");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password don not match");
    } else if (checkBoxValue == false) {
      showScaffoldMessanger(
          context: context, errorMessage: "Term and Conditions Not Agreed");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .register(
                name: _nameController.text,
                email: _emailController.text,
                password: _passwordController.text,
                confirmPassword: _confirmPasswordController.text)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          showScaffoldMessanger(
              context: context,
              backgroundColor: Colors.green,
              errorMessage: "User Registered Successfully");
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.home, (route) => false);
        });
      } on CustomHttpException catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(context: context, errorMessage: e.toString());
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showScaffoldMessanger(
            context: context, errorMessage: "Please Try Again Later");
      }
    }
  }
}
