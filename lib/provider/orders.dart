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
  final List<SandAddressData> _sandAddressData = [];

  List<OrderData> get pendingOrderData => [..._pendingOrderData];
  List<OrderData> get onTheWayOrderData => [..._onTheWayOrderData];
  List<OrderData> get deliveredOrderData => [..._deliveredOrderData];
  List<OrderData> get rejectedOrderData => [..._rejectedOrderData];

  List<SandAddressData> get sandAddressData => [..._sandAddressData];

  Future<void> getPending(String token) async {
    String url = "${AppConst.appUrl}/pending-orders";

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

  Future<void> getRejected(String token) async {
    String url = "${AppConst.appUrl}/rejected-orders";

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

  Future<void> getSandAddress(String token) async {
    String url = "${AppConst.appUrl}/locations";

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
        _sandAddressData.clear();
        final data = sandAddressModelFromJson(response.body);
        _sandAddressData.addAll(data.data);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}