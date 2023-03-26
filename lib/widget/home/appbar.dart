import 'package:flutter/material.dart';


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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const CircleAvatar(
                    //   radius: 20,
                    //   backgroundColor: AppColor.primaryColor,
                    // ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/Artboard 3-1.png",
                          fit: BoxFit.cover, color: Colors.white),
                    ),
                    const Icon(Icons.more_vert, size: 30)
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
