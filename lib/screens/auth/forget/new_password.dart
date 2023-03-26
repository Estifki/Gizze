import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/screens/auth/login.dart';
import 'package:ashewa_d/uitil/http_error.dart';
import 'package:ashewa_d/uitil/toast.dart';
import 'package:ashewa_d/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // leading: GestureDetector(
        //   onTap: () => Navigator.of(context).pop(),
        //   child: const Icon(Icons.arrow_back_ios_new, size: 22),
        // ),
        title:
            const Text("Reset Password", style: TextStyle(color: Colors.black)),
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
              _isLoading
                  ? Center(
                      child: Transform.scale(
                          scale: 0.6, child: const CircularProgressIndicator()),
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
                          "Reset Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      )),
    );
  }

  void validate() async {
    if (_passwordController.text.length < 6) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password must be at least 6 digit.");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showScaffoldMessanger(
          context: context, errorMessage: "Password don not match");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .changePassword(
                newPassword: _passwordController.text,
                confirmPassword: _confirmPasswordController.text)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
          showScaffoldMessanger(
              context: context,
              backgroundColor: Colors.green,
              errorMessage: "Password Changed Successfully");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
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
