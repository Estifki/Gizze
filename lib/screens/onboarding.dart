import '../const/const.dart';
import 'auth/login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widget/continue_as.dart';
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
            child: ContinueAsWidget(
                isLogin: isShowLoginVisible, isRegister: isShowRegister),
          ))
        else
          Container(),
        //
        //Page Indicator
        //

        Positioned(
          bottom: screenSize.height * 0.17,
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
            bottom: screenSize.height * 0.03,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SignInScreenForUser()),
                      );
                      // setState(() {
                      //   isShowLoginVisible = true;
                      // });
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
                  SizedBox(height: screenSize.height * 0.02),
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
