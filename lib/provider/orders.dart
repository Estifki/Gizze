import 'dart:convert';
import 'dart:io';

import 'package:ashewa_d/model/orders.dart';
import 'package:ashewa_d/model/sand_address.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import '../uitil/http_error.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderData> _pendingOrderData = [];
  final List<OrderData> _onTheWayOrderData = [];
  final List<OrderData> _deliveredOrderData = [];
  final List<OrderData> _rejectedOrderData = [];

  List<OrderData> get pendingOrderData => [..._pendingOrderData];
  List<OrderData> get onTheWayOrderData => [..._onTheWayOrderData];
  List<OrderData> get deliveredOrderData => [..._deliveredOrderData];
  List<OrderData> get rejectedOrderData => [..._rejectedOrderData];

  Future<void> getPending(String token, bool isDriver) async {
    String url = isDriver
        ? "${AppConst.appUrl}/driver-pending-orders"
        : "${AppConst.appUrl}/pending-orders";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      final decodedData = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        _pendingOrderData.clear();
        final data = ordersModelFromJson(response.body);

        _pendingOrderData.addAll(data.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> getOnTheWayOrders(String token) async {
  //   String url = "${AppConst.appUrl}/ontheway-orders";

  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //         HttpHeaders.authorizationHeader: "Bearer $token"
  //       },
  //     );
  //     final decodedData = jsonDecode(response.body);

  //     if (response.statusCode != 200) {
  //       throw CustomHttpException(errorMessage: decodedData["data"]);
  //     } else {
  //       _onTheWayOrderData.clear();
  //       final data = ordersModelFromJson(response.body);

  //       _onTheWayOrderData.addAll(data.data);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> getDelivered(String token) async {
  //   String url = "${AppConst.appUrl}/delivered-orders";

  //   try {
  //     http.Response response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Accept": "application/json",
  //         HttpHeaders.authorizationHeader: "Bearer $token"
  //       },
  //     );
  //     final decodedData = jsonDecode(response.body);

  //     if (response.statusCode != 200) {
  //       throw CustomHttpException(errorMessage: decodedData["data"]);
  //     } else {
  //       _deliveredOrderData.clear();
  //       final data = ordersModelFromJson(response.body);

  //       _deliveredOrderData.addAll(data.data);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> getRejected(String token, bool isDriver) async {
    String url = isDriver
        ? "${AppConst.appUrl}/driver-rejected-orders"
        : "${AppConst.appUrl}/rejected-orders";

    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        _rejectedOrderData.clear();
        final data = ordersModelFromJson(response.body);
        _rejectedOrderData.addAll(data.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> orderSand(
      {required String token,
      required String sandID,
      required String price,
      required String amount,
      required String locationName,
      required double lat,
      required double long}) async {
    String url = "${AppConst.appUrl}/my-orders";
    print(sandID);
    print(price);
    print(amount);
    print(locationName);

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonEncode({
            "sandLocationId": sandID,
            "amount": amount,
            "totalPrice": price,
            "locationName": locationName,
            "latitude": lat,
            "longitude": long
          }));
      final decodedData = jsonDecode(response.body);

      if (response.statusCode != 201) {
        throw CustomHttpException(errorMessage: decodedData["data"]);
      } else {
        print(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }
}
