import '../screens/driver/orders/details.dart';
import '../screens/user/order/details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/const.dart';
import '../provider/auth.dart';

class MyOrdersWidgetUser extends StatelessWidget {
  final String orderID;
  final String orderNo;

  final String amount;
  final String sandName;
  final String sandImage;
  final String pricePerCubic;
  final String totalPrice;
  final double sourceLat;
  final double sourceLong;

  final double destinationLat;
  final double destinationLong;

  final String sourceLocationName;

  final String destinationLocationName;

  final String deliveryManName;

  final String deliveryManPhone;

  const MyOrdersWidgetUser(
      {super.key,
      required this.orderID,
      required this.orderNo,
      required this.amount,
      required this.sandName,
      required this.sourceLocationName,
      required this.destinationLocationName,
      required this.sandImage,
      required this.pricePerCubic,
      required this.totalPrice,
      required this.sourceLat,
      required this.sourceLong,
      required this.destinationLat,
      required this.destinationLong,
      required this.deliveryManName,
      required this.deliveryManPhone});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MyOrdersDetailsScreen(
                  orderID: orderID,
                  sandName: sandName,
                  sandImage: sandImage,
                  amount: amount,
                  sourceName: sourceLocationName,
                  destinationName: destinationLocationName,
                  pricePerCubic: pricePerCubic,
                  totalPrice: totalPrice,
                  sourceLat: sourceLat,
                  sourceLong: sourceLong,
                  destinationLat: destinationLat,
                  destinationLong: destinationLong,
                  deliveryManName: deliveryManName,
                  deliveryManPhone: deliveryManPhone,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width * 0.92,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Stack(alignment: Alignment.centerLeft, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Code",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(
                    orderNo,
                    style: const TextStyle(color: AppColor.primaryColor),
                  ),
                  const SizedBox(height: 10),
                  // Text"(DateFormat('MMMM dd, yyyy')
                  //     .format(DateTime.parse(orderData.createdAt.toString()))"),
                  const SizedBox(height: 10),
                  Text(sandName),
                  // const Text(
                  //   "Sand Amount",
                  //   style: TextStyle(fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(height: 2),
                  Text("$amount m²"),
                ],
              ),
              Positioned(
                  right: 15.0,
                  child: Text(
                    "Br $totalPrice",
                    style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
