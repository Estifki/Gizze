import 'package:ashewa_d/provider/auth.dart';
import 'package:ashewa_d/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/onboarding.dart';

class CustomHomeAppBarWidget extends StatelessWidget {
  const CustomHomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 170,
      width: screenSize.width,
      color: Colors.black,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: AppColor.primaryColor,
                    // ),
                    const Icon(Icons.more_vert, size: 30, color: Colors.black),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/Artboard 3-1.png",
                          fit: BoxFit.cover, color: Colors.white),
                    ),

                    GestureDetector(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .LogOut();
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (context) => SplashScreen()));
                        },
                        child: const Icon(Icons.logout,
                            size: 25, color: Colors.white))
                  ]),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                height: 40,
                width: screenSize.width * 0.75,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.26),
                    borderRadius: BorderRadius.circular(6.0)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.grey.withOpacity(0.7),
                  cursorWidth: 1.0,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
            )
          ]),
    );
  }
}
