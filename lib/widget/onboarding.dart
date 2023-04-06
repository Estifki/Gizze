import 'package:flutter/material.dart';

class CustomOnboardingWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  CustomOnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      // color: Colors.black,
      child: Stack(alignment: Alignment.center, children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // isima
              //     ? Container(
              //         height: screenSize.height * 0.6,
              //         width: screenSize.width,
              //         decoration: BoxDecoration(
              //             image: DecorationImage(
              //                 image: AssetImage(imageUrl), fit: BoxFit.fitWidth)),
              //       )
              //     :
              Container(
                height: screenSize.height * 0.45,
                width: screenSize.width,
                color: Colors.black,
              ),
              // ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.03),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20.0, top: 10),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ]),
        //
        //Cenetr Image View
        //
        Positioned(
            top: screenSize.height * 0.21,
            child: Image.asset(imageUrl, height: screenSize.height * 0.23)),
      ]),
    );
  }
}
