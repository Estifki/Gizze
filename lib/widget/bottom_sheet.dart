import 'package:flutter/material.dart';

import '../const/const.dart';

showMoreSandInfo({
  required BuildContext context,
  required String sandName,
  required String sandDescription,
  required String sandPrice,
  required String sandImageUrl,
}) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (_) {
        return LayoutBuilder(builder: (context, _) {
          //<----- very important use this context
          return AnimatedPadding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              child: Container(
                  constraints:
                      const BoxConstraints(maxHeight: 1500, minHeight: 150),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Image.network(sandImageUrl),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          sandName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.flip_to_back_rounded,
                                color: AppColor.primaryColor,
                                size: 17,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "$sandPrice Birr/m²",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ]),
                        const SizedBox(height: 5),
                        Text(
                          sandDescription,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 46,
                          width: MediaQuery.of(context).size.width * 0.5,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.26),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.grey.withOpacity(0.7),
                            cursorWidth: 1.0,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              hintText: "Amount",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 46,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.26),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            cursorColor: Colors.grey.withOpacity(0.7),
                            cursorWidth: 1.0,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              hintText: "Delivery Location",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(6.0)),
                          child: const Text("Order Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ),
                        const SizedBox(height: 15),
                      ])));
        });
      });
}
