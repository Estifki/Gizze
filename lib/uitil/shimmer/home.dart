import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 35,
                  width: screenSize.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                height: screenSize.height * 0.15,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: screenSize.height * 0.15,
                        width: screenSize.width * 0.38,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.start, children: [

              //   Padding(
              //     padding: const EdgeInsets.only(left: 15),
              //     child: Container(
              //       height: screenSize.height * 0.15,
              //       width: screenSize.width * 0.38,
              //       decoration: BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //     ),
              //   ),
              //   Padding(
              //     padding: const EdgeInsets.only(left: 15),
              //     child: Container(
              //       height: screenSize.height * 0.15,
              //       width: screenSize.width * 0.38,
              //       decoration: BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(4),
              //       ),
              //     ),
              //   ),

              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Container(
              //     height: screenSize.height * 0.165,
              //     width: screenSize.width * 0.38,
              //     decoration: BoxDecoration(
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //   ),
              // ),
              // ]),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Container(
                  height: 40,
                  width: screenSize.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: screenSize.height * 0.23,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: screenSize.height * 0.23,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: screenSize.height * 0.23,
                          width: screenSize.width,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }
}
