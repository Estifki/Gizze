import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/const.dart';
import '../../../provider/auth.dart';
import '../../../uitil/http_error.dart';
import '../../../uitil/toast.dart';
import '../../driver/profile.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("Update Profile", style: TextStyle(fontSize: 18)),
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
                  hintText: "Name",
                  textInputType: TextInputType.visiblePassword,
                  controller: _nameController,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.abc, size: 0),
                  ),
                ),

                const SizedBox(height: 15),
                SignInTextFieldWidget(
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  controller: _emailController,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.abc, size: 0),
                  ),
                ),

                const SizedBox(height: 15),
                //
                //Confirm Password
                //

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
                              "Update Profile",
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
    if (_nameController.text.trim().isEmpty) {
      showScaffoldMessanger(
          context: context, errorMessage: "Name can't be empty!");
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(_emailController.text)) {
      showScaffoldMessanger(context: context, errorMessage: "Invalid email");
    } else {
      try {
        FocusScope.of(context).unfocus();
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .updateProfile(
                name: _nameController.text.trim(),
                email: _emailController.text.trim())
            .then((_) {
          showScaffoldMessanger(
              backgroundColor: Colors.green,
              context: context,
              errorMessage: "Profile Updated Successfully");
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
