import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/screens/auth/login.dart';
import 'package:ashewa_d/screens/auth/register/phone.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  bool isShowLoginVisible = false;
  bool isShowRegister = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isShowLoginVisible ? Colors.black : null,
      body: SafeArea(
          child: Stack(alignment: Alignment.center, children: [
        PageView(
          controller: pageController,
          children: [
            CustomOnboardingWidget(
              title: "WELCOME",
              description:
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
              imageUrl: "assets/Artboard 5-1.png",
            ),
            CustomOnboardingWidget(
              title: "FAST & SECURE",
              description:
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
              imageUrl: "assets/Artboard 7-1.png",
            ),
            CustomOnboardingWidget(
              title: "ON TIME DELIVERY",
              description:
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
              imageUrl: "assets/Artboard 6-1.png",
            ),
          ],
        ),
        //
        //Login As
        //
        if (isShowLoginVisible || isShowRegister)
          Positioned(
              child: GestureDetector(
            onTap: () {
              setState(() {
                isShowLoginVisible = false;
                isShowRegister = false;
              });
            },
            child: LoginAsWidget(
                isLogin: isShowLoginVisible, isRegister: isShowRegister),
          ))
        else
          Container(),
        //
        //Page Indicator
        //

        Positioned(
          top: screenSize.height * 0.78,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              dotHeight: 8.5,
              dotWidth: 8.5,
              dotColor: isShowLoginVisible || isShowRegister
                  ? Colors.grey.withOpacity(0.5)
                  : AppColor.primaryColor,
              activeDotColor: isShowLoginVisible || isShowRegister
                  ? Colors.grey.withOpacity(0.5)
                  : AppColor.primaryColor,
            ),
          ),
        ),

        //
        // Sign In and Create Account
        //
        Positioned(
            bottom: screenSize.height * 0.045,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowLoginVisible = true;
                      });
                    },
                    child: Container(
                      height: 46,
                      width: screenSize.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: isShowLoginVisible || isShowRegister
                            ? Colors.grey.withOpacity(0.5)
                            : AppColor.primaryColor,
                      ),
                      child: const Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //
                  //Create An account
                  //
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowRegister = true;
                      });
                    },
                    child: Text(
                      "Create An Account",
                      style: TextStyle(
                        fontSize: 18,
                        color: isShowLoginVisible || isShowRegister
                            ? Colors.grey.withOpacity(0.5)
                            : AppColor.primaryColor,
                      ),
                    ),
                  )
                ]))
      ])),
    );
  }
}

class LoginAsWidget extends StatelessWidget {
  bool isLogin;
  bool isRegister;

  LoginAsWidget({super.key, required this.isLogin, required this.isRegister});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.5),
      child: Center(
        child: Container(
          height: 140,
          width: 180,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (isLogin) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  } else if (isRegister) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PhoneRegisterScreen()));
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
                    print("Login for Driver");
                  } else if (isRegister) {
                    print("Register for Driver");
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
