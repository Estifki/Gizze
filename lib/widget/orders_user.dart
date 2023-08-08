import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/const.dart';
import '../screens/user/order/details.dart';

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
  final String orderStatus;
  final double destinationLat;
  final double destinationLong;

  final String sourceLocationName;

  final String destinationLocationName;

  final String deliveryManName;

  final String deliveryManPhone;
  final DateTime date;
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
      required this.deliveryManPhone,
      required this.orderStatus,
      required this.date});

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
                  orderStatus: orderStatus,
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
          height: 140,
          width: MediaQuery.of(context).size.width * 0.92,
          decoration: BoxDecoration(
            color: AppColor.secondaryColor.withOpacity(0.5),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Stack(alignment: Alignment.centerLeft, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Order Code",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 2),
                  Text(
                    orderNo,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  // Text"(DateFormat('MMMM dd, yyyy')
                  //     .format(DateTime.parse(orderData.createdAt.toString()))"),
                  const SizedBox(height: 10),
                  Text(
                    sandName,
                    style: const TextStyle(fontSize: 15.5),
                  ),
                  // const Text(
                  //   "Sand Amount",
                  //   style: TextStyle(fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat.yMMMEd().format(date),
                    style: const TextStyle(fontSize: 15.5),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Amount: $amount",
                    style: const TextStyle(fontSize: 15.5),
                  ),
                ],
              ),
              Positioned(
                  right: 15.0,
                  child: Text(
                    "Br $totalPrice",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
