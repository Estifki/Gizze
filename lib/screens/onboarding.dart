import 'package:ashewa_d/const/const.dart';
import 'package:ashewa_d/screens/auth/login.dart';
import 'package:ashewa_d/screens/auth/register/phone.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/onboarding.dart';

class OnBoardingScreen extends StatelessWidget {
  final PageController pageController = PageController();

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: pageController,
            children: const [
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
          //Page Indicator
          //

          Positioned(
            top: screenSize.height * 0.77,
            child: SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                  dotHeight: 8.5,
                  dotWidth: 8.5,
                  dotColor: AppColor.primaryColor,
                  activeDotColor: AppColor.primaryColor),
            ),
          ),

          //
          // Sign In and Create Account
          //
          Positioned(
              bottom: screenSize.height * 0.04,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                    child: Container(
                      height: 46,
                      width: screenSize.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: AppColor.primaryColor),
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const PhoneRegisterScreen()));
                    },
                    child: const Text(
                      "Create An Account",
                      style:
                          TextStyle(fontSize: 18, color: AppColor.primaryColor),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
