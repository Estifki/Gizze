import 'package:flutter/material.dart';

import '../const/const.dart';
import 'home/adderss_price.dart';

showMoreSandInfo({
  required BuildContext context,
  required String sandName,
  required String sandDescription,
  required String sandPrice,
  required String sandImageUrl,
  // required String eduaction,
  // required String bio,
  // required String pet,
  // required List images,
  // required List<String> interests,
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Login',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: 'enter email'),
                autofocus: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(hintText: 'enter password'),
                autofocus: true,
              ),
              SizedBox(height: 10),
            ],
          ),
        );
        // return SingleChildScrollView(
        //   child: Padding(
        //     padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         SizedBox(
        //           height: 200,
        //           width: double.infinity,
        //           child: Image.network(sandImageUrl),
        //         ),
        //         SizedBox(height: 5),
        //         Text(
        //           sandName,
        //           style: const TextStyle(
        //               color: Colors.black,
        //               fontSize: 19,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         SizedBox(height: 5),
        //         Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Icon(
        //                 Icons.flip_to_back_rounded,
        //                 color: AppColor.primaryColor,
        //                 size: 17,
        //               ),
        //               const SizedBox(width: 3),
        //               Text(
        //                 "$sandPrice Birr/m²",
        //                 maxLines: 1,
        //                 style: const TextStyle(
        //                     fontSize: 17,
        //                     color: Colors.black,
        //                     overflow: TextOverflow.ellipsis),
        //               ),
        //             ]),
        //         SizedBox(height: 5),
        //         Text(
        //           sandDescription,
        //           style: const TextStyle(color: Colors.black, fontSize: 17),
        //         ),
        //         SizedBox(height: 15),
        //         Container(
        //           height: 46,
        //           width: MediaQuery.of(context).size.width * 0.5,
        //           alignment: Alignment.centerLeft,
        //           decoration: BoxDecoration(
        //               color: Colors.grey.withOpacity(0.26),
        //               borderRadius: BorderRadius.circular(6.0)),
        //           child: TextField(
        //             // autofocus: true,
        //             textAlignVertical: TextAlignVertical.center,
        //             keyboardType: TextInputType.number,
        //             cursorColor: Colors.grey.withOpacity(0.7),
        //             cursorWidth: 1.0,
        //             style: const TextStyle(color: Colors.white),
        //             decoration: InputDecoration(
        //               isCollapsed: true,
        //               hintText: "Amount",
        //               border: InputBorder.none,
        //               contentPadding: const EdgeInsets.only(left: 10),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 15),
        //         Container(
        //           height: 46,
        //           width: MediaQuery.of(context).size.width,
        //           alignment: Alignment.centerLeft,
        //           decoration: BoxDecoration(
        //               color: Colors.grey.withOpacity(0.26),
        //               borderRadius: BorderRadius.circular(6.0)),
        //           child: TextField(
        //             textAlignVertical: TextAlignVertical.center,
        //             cursorColor: Colors.grey.withOpacity(0.7),
        //             cursorWidth: 1.0,
        //             style: const TextStyle(color: Colors.white),
        //             decoration: InputDecoration(
        //               isCollapsed: true,
        //               hintText: "Delivery Location",
        //               border: InputBorder.none,
        //               contentPadding: const EdgeInsets.only(left: 10),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 15),
        //         Container(
        //           height: 50,
        //           width: MediaQuery.of(context).size.width,
        //           alignment: Alignment.center,
        //           decoration: BoxDecoration(
        //               color: AppColor.primaryColor,
        //               borderRadius: BorderRadius.circular(6.0)),
        //           child: const Text("Order Now",
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 17,
        //                   fontWeight: FontWeight.bold),
        //               textAlign: TextAlign.center),
        //         )
        //       ],
        //     ),
        //   ),
        // );
      });
}
