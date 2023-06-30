import '../../const/const.dart';
import 'bottom_bar_driver.dart';
import 'my_sand/my_sand.dart';
import '../user/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth.dart';
import '../splash.dart';

class ProfileScreenForDriver extends StatefulWidget {
  const ProfileScreenForDriver({super.key});

  @override
  State<ProfileScreenForDriver> createState() => _ProfileScreenForDriverState();
}

class _ProfileScreenForDriverState extends State<ProfileScreenForDriver> {
  late Future _myProfile;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      _myProfile =
          Provider.of<AuthProvider>(context, listen: false).getMyProfile();
    }
    super.didChangeDependencies();
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void showPassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: _myProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return Consumer<AuthProvider>(
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenSize.height * 0.1),
                      Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor.withOpacity(0.2),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      value.profileData[0].profilePhotoUrl),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(value.profileData[0].name),
                      const SizedBox(height: 4),
                      Text(value.profileData[0].phone
                          .replaceAll("251", "+251 ")),

                      SizedBox(height: screenSize.height * 0.35),
                      // SignInTextFieldWidget(
                      //   hintText: "Name",
                      //   textInputType: TextInputType.name,
                      //   controller: _nameController,
                      //   suffixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: _obscurePassword
                      //         ? const Icon(Icons.visibility_off, size: 0)
                      //         : const Icon(Icons.visibility, size: 0),
                      //   ),
                      // ),
                      // const SizedBox(height: 15),
                      // SignInTextFieldWidget(
                      //   hintText: "Email",
                      //   textInputType: TextInputType.emailAddress,
                      //   controller: _emailController,
                      //   suffixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: _obscurePassword
                      //         ? const Icon(Icons.visibility_off, size: 0)
                      //         : const Icon(Icons.visibility, size: 0),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // SignInTextFieldWidget(
                      //   hintText: "Password",
                      //   textInputType: TextInputType.visiblePassword,
                      //   controller: _passwordController,
                      //   obscureText: _obscurePassword,
                      //   suffixIcon: IconButton(
                      //     onPressed: () => showPassword(),
                      //     icon: _obscurePassword
                      //         ? const Icon(Icons.visibility_off, size: 18)
                      //         : const Icon(Icons.visibility, size: 18),
                      //   ),
                      // ),
                      // const SizedBox(height: 30),
                      // Container(
                      //   height: 46,
                      //   width: screenSize.width,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: AppColor.primaryColor,
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   child: const Text(
                      //     "Update Profile",
                      //     style: TextStyle(
                      //         fontSize: 17,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MySandScreen(),
                        )),
                        child: Container(
                          height: 46,
                          width: screenSize.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Text(
                            "My Sands",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logOut();
                          Provider.of<DriverCustomBottomBarProvider>(context,
                                  listen: false)
                              .resetIndex();
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (context) => const SplashScreen()));
                        },
                        child: Container(
                          height: 46,
                          width: screenSize.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Text(
                            "LogOut",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 30),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         SizedBox(height: screenSize.height * 0.1),
      // Container(
      //   height: 90,
      //   width: 90,
      //   decoration: BoxDecoration(
      //       color: AppColor.primaryColor.withOpacity(0.2),
      //       shape: BoxShape.circle,
      //       image: const DecorationImage(
      //           image: AssetImage("assets/Artboard 3-1.png"),
      //           fit: BoxFit.cover)),
      // ),
      // const SizedBox(height: 20),
      // SignInTextFieldWidget(
      //   hintText: "Name",
      //   textInputType: TextInputType.name,
      //   controller: _nameController,
      //   suffixIcon: IconButton(
      //     onPressed: () {},
      //     icon: _obscurePassword
      //         ? const Icon(Icons.visibility_off, size: 0)
      //         : const Icon(Icons.visibility, size: 0),
      //   ),
      // ),
      // const SizedBox(height: 15),
      // SignInTextFieldWidget(
      //   hintText: "Email",
      //   textInputType: TextInputType.emailAddress,
      //   controller: _emailController,
      //   suffixIcon: IconButton(
      //     onPressed: () {},
      //     icon: _obscurePassword
      //         ? const Icon(Icons.visibility_off, size: 0)
      //         : const Icon(Icons.visibility, size: 0),
      //   ),
      // ),
      // const SizedBox(height: 20),
      // SignInTextFieldWidget(
      //   hintText: "Password",
      //   textInputType: TextInputType.visiblePassword,
      //   controller: _passwordController,
      //   obscureText: _obscurePassword,
      //   suffixIcon: IconButton(
      //     onPressed: () => showPassword(),
      //     icon: _obscurePassword
      //         ? const Icon(Icons.visibility_off, size: 18)
      //         : const Icon(Icons.visibility, size: 18),
      //   ),
      // ),
      // const SizedBox(height: 30),
      // Container(
      //   height: 46,
      //   width: screenSize.width,
      //   alignment: Alignment.center,
      //   decoration: BoxDecoration(
      //       color: AppColor.primaryColor,
      //       borderRadius: BorderRadius.circular(10.0)),
      //   child: const Text(
      //     "Update Profile",
      //     style: TextStyle(
      //         fontSize: 17,
      //         color: Colors.white,
      //         fontWeight: FontWeight.bold),
      //   ),
      // ),
      // const SizedBox(height: 30),
      // GestureDetector(
      //   onTap: () {
      //     Provider.of<UserAuthProvider>(context, listen: false)
      //         .logOut();
      //     Provider.of<UserCustomBottomBarProvider>(context,
      //             listen: false)
      //         .resetIndex();
      //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
      //         builder: (context) => const SplashScreen()));
      //   },
      //   child: Container(
      //     height: 46,
      //     width: screenSize.width,
      //     alignment: Alignment.center,
      //     decoration: BoxDecoration(
      //         color: AppColor.primaryColor,
      //         borderRadius: BorderRadius.circular(10.0)),
      //     child: const Text(
      //       "LogOut",
      //       style: TextStyle(
      //           fontSize: 17,
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold),
      //     ),
      //   ),
      // )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class SignInTextFieldWidget extends StatelessWidget {
  String hintText;
  // IconData prefixIcon;
  IconButton? suffixIcon;
  num screenNum;
  VoidCallback? showPassword;
  bool obscureText;
  TextInputType textInputType;
  TextEditingController controller;

  SignInTextFieldWidget(
      {super.key,
      required this.hintText,
      // required this.prefixIcon,
      required this.controller,
      required this.textInputType,
      this.showPassword,
      this.suffixIcon,
      this.obscureText = false,
      this.screenNum = 1});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: screenSize.width * screenNum,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(left: 15),
          suffixIcon: suffixIcon,
          hintText: hintText,
        ),
      ),
    );
  }
}
